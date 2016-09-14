//const uint8_t player_image[6][6] = {
int[][] player_image = {
{  0,   0,   0,   0,   0, 255, },
{  0, 255, 255, 255,   0, 255, },
{  0, 255,   0,   0,   0, 255, },
{  0, 255,   0, 255,   0, 255, },
{  0, 255,   0, 255,   0, 255, },
{  0,   0,   0,   0, 255,   0, },
};
//const uint32_t player_palate[] = {
int[] player_palate = {
0xFF0000, 
};
//struct Sprite player = {6, 6, &player_image[0][0], player_palate};
Sprite player = new Sprite(6, 6, player_image, player_palate);

//const uint8_t spider_image[6][6] = {
int[][] spider_image = {
{255, 255, 255, 255, 255, 255, },
{  0, 255,   0, 255,   0, 255, },
{255,   0,   0,   0, 255, 255, },
{  0,   0,   0,   0,   0, 255, },
{255,   0,   0,   0, 255, 255, },
{  0, 255,   0, 255,   0, 255, },
};
//const uint32_t spider_palate[] = {
int[] spider_palate = {
0x808080, 
};
//struct Sprite spider = {6, 6, &spider_image[0][0], spider_palate};
Sprite spider = new Sprite(6, 6, spider_image, spider_palate);

//const uint8_t wall_image[6][6] = {
int[][] wall_image = {
{255,   0, 255, 255,   0, 255, },
{  0,   0,   0,   0,   0,   0, },
{255,   0, 255, 255,   0, 255, },
{255,   0, 255, 255,   0, 255, },
{  0,   0,   0,   0,   0,   0, },
{255,   0, 255, 255,   0, 255, },
};
//const uint32_t wall_palate[] = {
int[] wall_palate = {
0x7F3300, 
};
//struct Sprite wall = {6, 6, &wall_image[0][0], wall_palate};
Sprite wall = new Sprite(6, 6, wall_image, wall_palate);

//const uint8_t ladder_image[12][6] = {
int[][] ladder_image = {
{255, 255, 255, 255, 255, 255, },
{255,   0, 255, 255,   0, 255, },
{255,   0, 255, 255,   0, 255, },
{255,   0,   0,   0,   0, 255, },
{255,   0, 255, 255,   0, 255, },
{255,   0, 255, 255,   0, 255, },
{255, 255, 255, 255, 255, 255, },
{255,   0, 255, 255,   0, 255, },
{255,   0, 255, 255,   0, 255, },
{255,   0,   0,   0,   0, 255, },
{255,   0, 255, 255,   0, 255, },
{255,   0, 255, 255,   0, 255, },
};
//const uint32_t ladder_palate[] = {
int[] ladder_palate = {
0xE55B00, 
};
//struct Sprite ladder = {6, 12, &ladder_image[0][0], ladder_palate};
Sprite ladder = new Sprite(6, 12, ladder_image, ladder_palate);

//const uint8_t grass_image[6][6] = {
int[][] grass_image = {
{255,   0, 255,   0, 255, 255, },
{255,   0, 255,   0, 255, 255, },
{255, 255, 255, 255, 255, 255, },
{255, 255, 255, 255, 255, 255, },
{255, 255, 255, 255, 255, 255, },
{255, 255, 255, 255, 255, 255, },
};
//const uint32_t grass_palate[] = {
int[] grass_palate = {
0x00FF00, 
};
//struct Sprite grass = {6, 6, &grass_image[0][0], grass_palate};
Sprite grass = new Sprite(6, 6, grass_image, grass_palate);

//const uint8_t bat_image[6][6] = {
int[][] bat_image = {
{  0,   0,   0,   0,   0, 255, },
{  0, 255, 255, 255, 255,   0, },
{  0, 255,   0,   0,   0, 255, },
{  0, 255, 255, 255, 255,   0, },
{  0, 255, 255, 255, 255,   0, },
{  0,   0,   0,   0,   0, 255, },
};
//const uint32_t bat_palate[] = {
int[] bat_palate = {
0xFF6A00, 
};
//struct Sprite bat = {6, 6, &bat_image[0][0], bat_palate};
Sprite bat = new Sprite(6, 6, bat_image, bat_palate);



//const uint8_t stake_image[6][6] = {
int[][] stake_image = {
{255,   0, 255, 255, 255, 255, },
{255, 255,   0, 255, 255, 255, },
{255, 255,   0, 255, 255, 255, },
{255, 255, 255,   0, 255, 255, },
{255, 255, 255,   0, 255, 255, },
{255, 255, 255, 255,   0, 255, },
};
//const uint32_t stake_palate[] = {
int[] stake_palate = {
0x7A5230, 
};
//struct Sprite stake = {6, 6, &stake_image[0][0], stake_palate};
Sprite stake = new Sprite(6, 6, stake_image, stake_palate);

//const uint8_t heart_image[6][6] = {
int[][] heart_image = {
{255, 255, 255, 255, 255, 255, },
{255, 255,   0, 255, 255, 255, },
{255, 255,   0, 255, 255, 255, },
{  0,   0,   0,   0,   0, 255, },
{255, 255,   0, 255, 255, 255, },
{255, 255,   0, 255, 255, 255, },
};
//const uint32_t heart_palate[] = {
int[] heart_palate = {
0xE55BFF, 
};
//struct Sprite heart = {6, 6, &heart_image[0][0], heart_palate};
Sprite heart = new Sprite(6, 6, heart_image, heart_palate);

//const uint8_t x_image[6][6] = {
int[][] sprite_x_image = {
{255, 255, 255, 255, 255, 255, },
{  0, 255, 255, 255,   0, 255, },
{255,   0, 255,   0, 255, 255, },
{255, 255,   0, 255, 255, 255, },
{255,   0, 255,   0, 255, 255, },
{  0, 255, 255, 255,   0, 255, },
};
//const uint32_t sprite_x_palate[] = {
int[] sprite_x_palate = {
0xFFFFFF, 
};
//struct Sprite sprite_x = {6, 6, &sprite_x_image[0][0], sprite_x_palate};
Sprite sprite_x = new Sprite(6, 6, sprite_x_image, sprite_x_palate);
