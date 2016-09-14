import java.awt.event.KeyEvent;

OctoWS2811 leds = new OctoWS2811(240, 60);

enum EntityType
{
    GRASS,
    WALL,
    SPIDER,
    BAT,
    STAKE,
    NONE
};

class Entity
{
    public Entity(int _x, int _y, int _u, EntityType _Type, Sprite _s)
    {
        x = _x;
        y = _y;
        alarm = _u;
        Type = _Type;
        sprite = _s;
    }
    public int x, y;
    final int alarm;
    public int tick = 0;
    public EntityType Type;
    public Sprite sprite;
    public boolean active = true;
}

// TODO: combine Bat and Stake into MovingEntity, pull out constant variables
class Stake extends Entity
{
    public Stake(int _x, int _y, int _dir)
    {
        super(_x, _y, 7, EntityType.STAKE, stake);
        if (_dir == UP)
        {
            dx = 0;
            dy = -1;
        }
        else if (_dir == DOWN)
        {
            dx = 0;
            dy = 1;
        }
        else if (_dir == LEFT)
        {
            dx = -1;
            dy = 0;
        }
        else if (_dir == RIGHT)
        {
            dx = 1;
            dy = 0;
        }
        dir = _dir;
    }

    public int dx, dy, dir;
}

class Bat extends Entity
{
    public Bat(int _x, int _y)
    {
        super(_x, _y, 15, EntityType.BAT, bat);
        fx = _x;
        fy = _y;
    }
    public float fx, fy, dx, dy;

    // manhattan distance
    public static final int detect_range = 8;

    // total cycles for attack
    public static final int cycle_duration = 10;
    // number of cycles to fly
    public static final int flight_duration = 6;
    public int cycle_tick = cycle_duration;
}

// TODO: Use pre-allocated arrays
ArrayList<Entity> StaticEntities;
ArrayList<Entity> Spiders;
ArrayList<Bat> Bats;
ArrayList<Stake> Stakes;

int ladder_x, ladder_y;

// player variables
int px = 2, py = 2;
int dpx = 0, dpy = 0, pdir;

int p_stakes = 3;

int p_health = 3;

final int palarm = 30;
int ptick = 0;

final int p_hurtflash_interval = 15;
final int p_invincible_time = 120;
int p_invincible_tick = 0;

// camera variables
int camx = 0, camy = 0;

// map variables
int grid_length;
int map_size  = 3;
final int grid_size = 11;
final int room_size = 7;
final int hall_size = 4;
final int hall_width = 4;

final int tile_size = 6;

void UpdateCamera()
{
    if ((px - camx) >= 7 && ((grid_length - camx) > 7))
    {
       camx++;
    }
    else if ((px - camx) <= 2 && (camx > 0))
    {
       camx--;
    }
    if ((py - camy) >= 3 && ((grid_length - camy) > 3))
    {
       camy++;
    }
    else if ((py - camy) <= 1 && (camy > 0))
    {
       camy--;
    }
}

void TestCollisionSpider(Entity ent, int dir_from)
{
    if (ent.x == px && ent.y == py)
    {
        ent.active = false;
        if (p_invincible_tick == 0)
        {
            p_invincible_tick = p_invincible_time;
            p_health--;
            if (p_health <= 0)
            {
                map_size = 3;
                ready = false;
            }
        }
        return;
    }
    int a = 0;
    int b = 0;
    if (dir_from > 16)
    {
        return;
    }
    if ((dir_from & UP) == UP)
    {
        b = 1;
    }
    else if ((dir_from & DOWN) == DOWN)
    {
        b = -1;
    }
    else if ((dir_from & LEFT) == LEFT)
    {
        a = 1;
    }
    else if ((dir_from & RIGHT) == RIGHT)
    {
        a = -1;
    }
    for (Entity e : StaticEntities)
    {
        if ((ent == e && !e.active) || (e == ent))
        {
            continue;
        }
        if (e.x == ent.x && e.y == ent.y)
        {
            if (e.Type == EntityType.WALL)
            {
                ent.x += a;
                ent.y += b;
            }
            else if (e.Type == EntityType.SPIDER)
            {
                // health--;
            }
            return;
        }
    }
    return;
}

void TestCollisionStake(Stake s)
{
    for (Entity e : StaticEntities)
    {
        if (e.x == s.x && e.y == s.y)
        {
            if (e.Type == EntityType.WALL)
            {
                s.active = false;
                return;
            }
            if (e.Type == EntityType.SPIDER)
            {
                s.active = false;
                e.active = false;
                return;
            }
        }
    }
    for (Bat b : Bats)
    {
        if (s.x == b.x && s.y == b.y)
        {
            s.active = false;
            b.active = false;
            return;
        }
    }
}

void TestCollisionPlayer(int dir_from)
{
    int a = 0;
    int b = 0;
    if (dir_from == UP)
    {
        b = 1;
    }
    else if (dir_from == DOWN)
    {
        b = -1;
    }
    else if (dir_from == LEFT)
    {
        a = 1;
    }
    else if (dir_from == RIGHT)
    {
        a = -1;
    }
    else
    {
        return;
    }
    if (px== ladder_x && (py == ladder_y || py == (ladder_y + 1)))
    {
        ready = false;
        return;
    }
    for (Entity e : StaticEntities)
    {
        if (!e.active)
        {
            continue;
        }
        if (e.x == px && e.y == py)
        {
            if (e.Type == EntityType.WALL)
            {
                px += a;
                py += b;
            }
            else if (e.Type == EntityType.SPIDER)
            {
                e.active = false;
                if (p_invincible_tick == 0)
                {
                    p_invincible_tick = p_invincible_time;
                    p_health--;
                    if (p_health <= 0)
                    {
                        map_size = 3;
                        p_health = 3;
                        ready = false;
                    }
                }
            }
            return;
        }
    }
    for (Bat bat : Bats)
    {
        if (px == bat.x && py == bat.y)
        {
            bat.active = false;
            if (p_invincible_tick == 0)
            {
                p_invincible_tick = p_invincible_time;
                p_health--;
                if (p_health <= 0)
                {
                    map_size = 3;
                    p_health = 3;
                    ready = false;
                }
            }
        }
    }
    // StaticEntities.removeAll(EntsToRemove);
    return;
}

final int UP = 1;
final int DOWN = 2;
final int LEFT = 4;
final int RIGHT = 8;

void keyPressed()
{
  switch (key)
  {
    case 'w':
        ptick = 0;
        if (py > 0)
        {
            py = py - 1;
            TestCollisionPlayer(UP);
            pdir = UP;
        }
        dpx = 0;
        dpy = -1;
        break;
    case 's':
        if (py < grid_length - 1)
        {
            py = py + 1;
            TestCollisionPlayer(DOWN);
            pdir = DOWN;
        }
        dpx = 0;
        dpy = 1;
        break;
    case 'a':
        ptick = 0;
        if (px > 0)
        {
            px = px - 1;
            TestCollisionPlayer(LEFT);
            pdir = LEFT;
        }
        dpx = -1;
        dpy = 0;
        break;
    case 'd':
        ptick = 0;
        if (px < grid_length - 1)
        {
            px = px + 1;
            TestCollisionPlayer(RIGHT);
            pdir = RIGHT;
        }
        dpx = 1;
        dpy = 0;
        break;
    case 'i':
        // throw stake up
        if (p_stakes > 0)
        {
            p_stakes--;
            Stakes.add(new Stake(px, py - 1, UP));
        }
        break;
    case 'k':
        // throw stake down 
        if (p_stakes > 0)
        {
            p_stakes--;
            Stakes.add(new Stake(px, py + 1, DOWN));
        }
        break;
    case 'j':
        // throw stake right
        if (p_stakes > 0)
        {
            p_stakes--;
            Stakes.add(new Stake(px - 1, py, LEFT));
        }
        break;
    case 'l':
        // throw stake left
        if (p_stakes > 0)
        {
            p_stakes--;
            Stakes.add(new Stake(px + 1, py, RIGHT));
        }
        break;

    // player 2
    // probably unnecessary, clone controls later
    // case '5': buttons.y2 = true; break;
    // case '1': buttons.a2 = true; break;
    // case '2': buttons.x2 = true; break;
    // case '3': buttons.b2 = true; break;

    // case CODED:
    //   switch (keyCode)
    //   {
    //     case KeyEvent.VK_UP:       buttons.u2 = true; break;
    //     case KeyEvent.VK_DOWN:     buttons.d2 = true; break;
    //     case KeyEvent.VK_LEFT:     buttons.l2 = true; break;
    //     case KeyEvent.VK_RIGHT:    buttons.r2 = true; break;
    //     case KeyEvent.VK_KP_UP:    buttons.y2 = true; break;
    //     case KeyEvent.VK_KP_DOWN:  buttons.a2 = true; break;
    //     case KeyEvent.VK_KP_LEFT:  buttons.x2 = true; break;
    //     case KeyEvent.VK_KP_RIGHT: buttons.b2 = true; break;
    //   }
    // break;    
  }
  UpdateCamera();
}

void keyReleased()
{
  switch (key)
  {
    case 'w':
    case 's':
    case 'a':
    case 'd':
        dpy = 0;
        dpx = 0;
        ptick = 0;
        break;
    case 'i':
        // do thing with top face button
        break;
    case 'k':
        // do thing with bottom face button
        break;
    case 'j':
        // do thing with leftface button
        break;
    case 'l':
        // do thing with right face button
        break;

    // player 2
    // probably unnecessary clone controls later
    // case '5': buttons.y2 = true; break;
    // case '1': buttons.a2 = true; break;
    // case '2': buttons.x2 = true; break;
    // case '3': buttons.b2 = true; break;

    // case CODED:
    //   switch (keyCode)
    //   {
    //     case KeyEvent.VK_UP:       buttons.u2 = true; break;
    //     case KeyEvent.VK_DOWN:     buttons.d2 = true; break;
    //     case KeyEvent.VK_LEFT:     buttons.l2 = true; break;
    //     case KeyEvent.VK_RIGHT:    buttons.r2 = true; break;
    //     case KeyEvent.VK_KP_UP:    buttons.y2 = true; break;
    //     case KeyEvent.VK_KP_DOWN:  buttons.a2 = true; break;
    //     case KeyEvent.VK_KP_LEFT:  buttons.x2 = true; break;
    //     case KeyEvent.VK_KP_RIGHT: buttons.b2 = true; break;
    //   }
    // break;    
  }
}

boolean ready = false;

void make_room()
{
    StaticEntities.clear();

    int[][] rooms = new int[map_size][map_size];
    int num_rooms = map_size * map_size;
    int start = (int)(Math.random() * num_rooms);
    int end = (int)(Math.random() * num_rooms);

    while (end == start)
    {
        end = (int)(Math.random() * num_rooms);
    }

    int grid_start_x = start % map_size;
    int grid_start_y = start / map_size;

    int grid_end_x = end % map_size;
    int grid_end_y = end / map_size;

    px = (grid_start_x * grid_size) + (room_size / 2);
    py = (grid_start_y * grid_size) + (room_size / 2);

    ladder_x = (grid_end_x * grid_size) + (room_size / 2);
    ladder_y = (grid_end_y * grid_size) + (room_size / 2);

    // gaurantee solution
    // TODO: Make more interesting solutions
    // manulaly simulate traversing rooms?
    // max step count?
    while (grid_start_x < grid_end_x)
    {
        rooms[grid_start_y][grid_start_x] |= RIGHT;
        rooms[grid_start_y][grid_start_x + 1] |= LEFT;
        grid_start_x++;
    }
    while (grid_start_x > grid_end_x)
    {
        rooms[grid_start_y][grid_start_x] |= LEFT;
        rooms[grid_start_y][grid_start_x - 1] |= RIGHT;
        grid_start_x--;
    }
    while (grid_start_y < grid_end_y)
    {
        rooms[grid_start_y][grid_start_x] |= DOWN;
        rooms[grid_start_y + 1][grid_start_x] |= UP;
        grid_start_y++;
    }
    while (grid_start_y > grid_end_y)
    {
        rooms[grid_start_y][grid_start_x] |= UP;
        rooms[grid_start_y - 1][grid_start_x] |= DOWN;
        grid_start_y--;
    }

    int hall_cutoff = (room_size - hall_width) / 2 + 1;

    // set total grid length for bounds checking
    grid_length = map_size * grid_size;

    float chance = 0.25;

    for (int j = 0; j < map_size; j++)
    {
        for (int i = 0; i < map_size; i++)
        {
            if (Math.random() < 0.25)
            {
                Bats.add(
                    new Bat(
                        grid_size * i + 2 * room_size / 3,
                        grid_size * j + room_size / 3
                ));
            }
            if (Math.random() < 0.35)
            {
                Entity Spider = new Entity(
                    grid_size * i + room_size / 3,
                    grid_size * j + room_size / 3,
                    100,
                    EntityType.SPIDER,
                    spider);

                Spiders.add(Spider);
            }
            if (Math.random() < 0.35)
            {
                Entity Spider = new Entity(
                    grid_size * i + 2 * room_size / 3,
                    grid_size * j + 2 * room_size / 3,
                    100,
                    EntityType.SPIDER,
                    spider);

                Spiders.add(Spider);
            }
            // draw left side wall
            if ((rooms[j][i] & LEFT) == 0)
            {
                for (int x = 0; x < room_size; x++)
                {
                    StaticEntities.add(
                        new Entity(grid_size * i,
                        grid_size * j + x,
                        -1,
                        EntityType.WALL,
                        wall)
                    );
                }
            }
            else
            {
                for (int x = 0; x < hall_cutoff; x++)
                {
                    StaticEntities.add(
                        new Entity(
                            grid_size * i,
                            grid_size * j + x,
                            -1,
                            EntityType.WALL,
                            wall
                    ));
                }
                for (int x = hall_cutoff + hall_width; x < room_size; x++)
                {
                    StaticEntities.add(
                        new Entity(
                            grid_size * i,
                            grid_size * j + x,
                            -1,
                            EntityType.WALL,
                            wall
                    ));
                }
            }

            // draw top side wall
            if ((rooms[j][i] & UP) == 0)
            {
                for (int x = 0; x < room_size; x++)
                {
                    StaticEntities.add(
                        new Entity(grid_size * i + x,
                        grid_size * j,
                        -1,
                        EntityType.WALL,
                        wall)
                    );
                }
            }
            else
            {
                for (int x = 0; x < hall_cutoff; x++)
                {
                    StaticEntities.add(
                        new Entity(grid_size * i + x,
                        grid_size * j,
                        -1,
                        EntityType.WALL,
                        wall)
                    );                                             
                }                                                  
                for (int x = hall_cutoff + hall_width; x < room_size; x++)                        
                {                                                  
                    StaticEntities.add(                                  
                        new Entity(grid_size * i + x,
                        grid_size * j,
                        -1,
                        EntityType.WALL,
                        wall)
                    );
                }
            }

            // draw right side wall
            if (((rooms[j][i] & RIGHT) == RIGHT)
                || (i < (map_size - 1))
                && (Math.random() < chance))
            {
                rooms[j][i] |= RIGHT;
                rooms[j][i + 1] |= LEFT;
                for (int x = 0; x < hall_cutoff; x++)
                {
                    StaticEntities.add(
                        new Entity(
                            grid_size * i + room_size,
                            grid_size * j + x,
                            -1,
                            EntityType.WALL,
                            wall
                    ));
                }
                for (int x = 0; x <= hall_size; x++)
                {
                    StaticEntities.add(
                        new Entity(
                            grid_size * i + x + room_size,
                            grid_size * j + hall_cutoff,
                            -1,
                            EntityType.WALL,
                            wall
                    ));                                                             
                    StaticEntities.add(
                        new Entity(
                            grid_size * i + x + room_size,
                            grid_size * j + hall_cutoff + hall_width - 1,
                            -1,
                            EntityType.WALL,
                            wall
                    ));                                                             
                }
                for (int x = hall_cutoff + hall_width; x <= room_size; x++)
                {
                    StaticEntities.add(
                        new Entity(
                            grid_size * i + room_size,
                            grid_size * j + x,
                            -1,
                            EntityType.WALL,
                            wall
                    ));
                }
            }
            else
            {
                for (int x = 0; x <= room_size; x++)
                {
                    StaticEntities.add(
                        new Entity(grid_size * i + room_size,
                        grid_size * j + x,
                        -1,
                        EntityType.WALL,
                        wall)
                    );
                }
            }

            // draw bottom side wall
            if (((rooms[j][i] & DOWN) == DOWN)
                || (j < (map_size - 1))
                && (Math.random() < chance))
            {
                rooms[j][i] |= DOWN;
                rooms[j + 1][i] |= UP;
                for (int x = 0; x < hall_cutoff; x++)
                {
                    StaticEntities.add(
                        new Entity(grid_size * i + x,
                        grid_size * j + room_size,
                        -1,
                        EntityType.WALL,
                        wall)
                    );                                             
                }                                                  
                for (int x = 0; x <= hall_size; x++)
                {
                    StaticEntities.add(
                        new Entity(
                            grid_size * i + hall_cutoff,
                            grid_size * j + x + room_size,
                            -1,
                            EntityType.WALL,
                            wall
                    ));                                                             
                    StaticEntities.add(
                        new Entity(
                            grid_size * i + hall_cutoff + hall_width - 1,
                            grid_size * j + x + room_size,
                            -1,
                            EntityType.WALL,
                            wall
                    ));                                                             
                }
                for (int x = hall_cutoff + hall_width; x < room_size; x++)                        
                {                                                  
                    StaticEntities.add(                                  
                        new Entity(
                            grid_size * i + x,
                            grid_size * j + room_size,      
                            -1,     
                            EntityType.WALL,        
                            wall)
                    );
                }
            }
            else
            {
                for (int x = 0; x < room_size; x++)
                {
                    StaticEntities.add(
                        new Entity(grid_size * i + x,
                            grid_size * j + room_size,
                            -1,
                            EntityType.WALL,
                            wall)
                    );
                }
            }

            // draw grass
            for (int x = 1; x < room_size - 1; x++)
            {
                int rando = (int)(Math.random() * (room_size));
                if (rando < room_size - 2)
                {
                    StaticEntities.add(
                        new Entity(
                            grid_size * i + x,
                            grid_size * j + 1 + rando,
                            -1,
                            EntityType.GRASS,
                            grass
                        ));
                }
            }
        }
    }

    // print map
    print(map_size, 'x', map_size, '\n');
    for (int j = 0; j < map_size; j++)
    {
        for (int i = 0; i < map_size; i++)
        {
            if (i == (start % 3) && j == (start / 3))
            {
                print ('S');
            }
            if (i == grid_end_x && j == grid_end_y)
            {
                print ('E');
            }
            if ((rooms[j][i] & UP) == UP)
            {
                print('U');
            }
            if ((rooms[j][i] & LEFT) == LEFT)
            {
                print('L');
            }
            if ((rooms[j][i] & DOWN) == DOWN)
            {
                print('D');
            }
            if ((rooms[j][i] & RIGHT) == RIGHT)
            {
                print('R');
            }
            print('\t');
        }
        print('\n');
    }

    ready = true;
}

void setup() 
{
    if (platformNames[platform] == "windows")
      midi.begin();
    else if (platformNames[platform] == "macosx")
      midi.begin("Bus 1");
    else
      midi.list(); // List all available MIDI device names and indexes to the console.
    midi.setInstrument(0, MIDIinstrument.SynthDrum);
    midi.setInstrument(1, MIDIinstrument.Tuba);
    midi.setInstrument(2, MIDIinstrument.Applause);
    
    //frameRate(120);
    size(920, 500, P2D);
    background(32, 32, 32);
    leds.begin();
    leds.show();
    
    // TODO: After switching to pre-allocated arrays, fill the
    // arrays with sentinel objects so we take care of allocation during setup()
    StaticEntities = new ArrayList<Entity>();
    // ensureCapacity(size)
    Spiders = new ArrayList<Entity>();
    Bats = new ArrayList<Bat>();
    Stakes = new ArrayList<Stake>();

    // add grass
    // StaticEntities.add(new Entity(0, 0, EntityType.GRASS, grass));
    // StaticEntities.add(new Entity(2, 0, EntityType.GRASS, grass));
    // StaticEntities.add(new Entity(3, 3, EntityType.GRASS, grass));
    // StaticEntities.add(new Entity(8, 4, EntityType.GRASS, grass));
    // StaticEntities.add(new Entity(9, 5, EntityType.GRASS, grass));

    make_room();
}

// TODO: Optimize via object pooling. Don't do draw calls on objects outside
// the camera
void draw()
{
    // uhh
    midi.processNoteOffs();
    // clear screen
    DrawRect(0, 0, 60, 32, 0);
    if (ready)
    {
        UpdateCamera();
        if (p_invincible_tick > 0)
        {
            p_invincible_tick--;
            if (p_invincible_tick % p_hurtflash_interval == 0)
            {
                player_palate[0] = (p_invincible_tick == 0) ? 0xFF0000 : (player_palate[0] ^ 0x00FFFF);
            }
        }
        DrawSprite(player, (px - camx) * tile_size, (py - camy) * tile_size, false);

        ptick++;
        if (ptick >= palarm)
        {
            ptick = 0;
            px += dpx;
            py += dpy;
            TestCollisionPlayer(pdir);
        }
        // Draw ladder
        DrawSprite(ladder, (ladder_x - camx) * tile_size, (ladder_y - camy) * tile_size, false);
        // update static entities
        for (Entity e : StaticEntities)
        {
            if (!e.active)
            {
                continue;
            }
            DrawSprite(e.sprite, (e.x - camx) * tile_size, (e.y - camy) * tile_size, false);
        }
        // update stakes
        for (Stake s : Stakes)
        {
            if (!s.active)
            {
                continue;
            }
            if (s.tick >= s.alarm)
            {
                s.x += s.dx;
                s.y += s.dy;
                for (Entity e : StaticEntities)
                {
                    if (e.x == s.x && e.y == s.y)
                    {
                        if (e.Type == EntityType.WALL)
                        {
                            s.active = false;
                            break;
                        }
                    }
                }
                if (!s.active)
                {
                    continue;
                }
                for (Entity sp : Spiders)
                {
                    if (s.x == sp.x && s.y == sp.y)
                    {
                        s.active = false;
                        sp.active = false;
                        break;
                    }
                }
                if (!s.active)
                {
                    continue;
                }
                for (Bat b : Bats)
                {
                    if (s.x == b.x && s.y == b.y)
                    {
                        s.active = false;
                        b.active = false;
                        break;
                    }
                }
                s.tick = 0;
            }
            else
            {
                s.tick++;
            }
            DrawSprite(s.sprite, (s.x - camx) * tile_size, (s.y - camy) * tile_size, false);
        }
        // update spiders
        for (Entity e : Spiders)
        {
            if (!e.active)
            {
                continue;
            }
            if (e.tick >= e.alarm)
            {
                double rando = Math.random();
                if (rando < 0.5)
                {
                    if (rando < 0.25)
                    {
                        e.x += 1;
                        TestCollisionSpider(e, RIGHT);
                    }
                    else
                    {
                        e.y += 1;
                        TestCollisionSpider(e, DOWN);
                    }
                }
                else
                {
                    if (rando < 0.75)
                    {
                        e.x -= 1;
                        TestCollisionSpider(e, LEFT);
                    }
                    else
                    {
                        e.y -= 1;
                        TestCollisionSpider(e, UP);
                    }
                }
                e.tick = 0;
            }
            else
            {
                e.tick++;
            }
            DrawSprite(e.sprite, (e.x - camx) * tile_size, (e.y - camy) * tile_size, false);
        }

        // update bats
        for (Bat b : Bats)
        {
            if (!b.active)
            {
                continue;
            }
            if (b.tick >= b.alarm)
            {
                if (b.cycle_tick >= Bat.cycle_duration)
                {
                    int dx = px - b.x;
                    int dy = py - b.y;
                    int abs_dx = Math.abs(dx);
                    int abs_dy = Math.abs(dy);
                    if ((abs_dx + abs_dy) <= Bat.detect_range)
                    {
                        if (abs_dx >= abs_dy)
                        {
                            b.dx = 1;
                            b.dy = (abs_dy == 0) ? 0 : (1.0 / abs_dy);
                        }                                   
                        else                                
                        {                                   
                            b.dx = (abs_dx == 0) ? 0 : (1.0 / abs_dx);
                            b.dy = 1;
                        }
                        if (dx < 0)
                        {
                            b.dx *= -1;
                        }
                        if (dy < 0)
                        {
                            b.dy *= -1;
                        }
                        b.cycle_tick = 0;
                    }
                }
                else if (b.cycle_tick < Bat.flight_duration)
                {
                    b.fx += b.dx;
                    b.fy += b.dy;
                    b.x = (int)b.fx;
                    b.y = (int)b.fy;

                    if (b.x == px && b.y == py)
                    {
                        p_health--;
                        b.active = false;
                    }
                }
                b.cycle_tick++;
                b.tick = 0;
            }
            else
            {
                b.tick++;
            }
            DrawSprite(bat, (b.x - camx) * tile_size, (b.y - camy) * tile_size, false);
        }

        // ui stuff
        for (int i = 1; i <= p_health; i++)
        {
            DrawSprite(heart, 60 - 6 * i, 0, false);
        }
        DrawSprite(stake, 42, 6, false);
        DrawSprite(sprite_x, 48, 6, false);
        DrawNumber(p_stakes, 54, 6, 0xffffff, false);

        leds.show();
    }
    else
    {
        // map_size = map_size + fib_var;
        // fib_var = map_size - fib_var;
        map_size++;
        p_invincible_tick = 0;
        make_room();
    }
}
