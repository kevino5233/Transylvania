//const uint8_t player_image[8][8] = {
int[][] player_image = {
{255,   0,   0,   0,   0,   0, 255, 255, },
{  0,   255, 255, 255, 255, 255,   0, 255, },
{  0,   255, 255,   0,   0, 255,   0, 255, },
{  0,   255,   0, 255,   0, 255,   0, 255, },
{  0,   255,   0, 255,   0, 255,   0, 255, },
{  0,   255,   0,   255,   0,   255,   0, 255, },
{  0,   255,   255,   0,   255,   0,   0,   255, },
{255,   0,   0,   0,   0,   0, 255,   0, },
};
//const uint32_t player_palate[] = {
int[] player_palate = {
0xFF0000, 0x000000, 
};
//struct Sprite player = {8, 8, &player_image[0][0], player_palate};
Sprite player = new Sprite(8, 8, player_image, player_palate);

//const uint8_t grass_image[8][8] = {
int[][] grass_image = {
{  255,   255,   255,   1,   255,   255,   255,   2, },
{  255,   3,   255,   255,   255,   255,   255,   255, },
{  255,   255,   255,   255,   255,   4,   255,   255, },
{  255,   255,   255,   5,   255,   255,   255,   3, },
{255,   6,   255,   255,   255,   255,   255,   255, },
{255, 255,   255,   255,   255,   6,   255,   255, },
{255, 255, 255,   7, 255, 255, 255,   7, },
{255,   7, 255, 255, 255, 255, 255, 255, },
};
//const uint32_t grass_palate[] = {
int[] grass_palate = {
0x000000, 0x00F100, 0x00EE00, 0x00FA00, 0x00F500, 0x00FB00, 0x00FE00, 0x00FF00, 
};
//struct Sprite grass = {8, 8, &grass_image[0][0], grass_palate};
Sprite grass = new Sprite(8, 8, grass_image, grass_palate);

//const uint8_t wall_image[8][8] = {
int[][] wall_image = {
{255, 255,   0, 255, 255,   0, 255, 255, },
{255, 255,   0, 255, 255,   0, 255, 255, },
{  0,   0,   0,   0,   0,   0,   0,   0, },
{255, 255,   0, 255, 255,   0, 255, 255, },
{255, 255,   0, 255, 255,   0, 255, 255, },
{  0,   0,   0,   0,   0,   0,   0,   0, },
{255, 255,   0, 255, 255,   0, 255, 255, },
{255, 255,   0, 255, 255,   0, 255, 255, },
};
//const uint32_t wall_palate[] = {
int[] wall_palate = {
0xCBCB4B, 
};
//struct Sprite wall = {8, 8, &wall_image[0][0], wall_palate};
Sprite wall = new Sprite(8, 8, wall_image, wall_palate);

//const uint8_t ladder_image[9][8] = {
int[][] ladder_image = {
{255, 255,   0, 255, 255,   0, 255, 255, },
{255,   0,   0,   0,   0,   0,   0, 255, },
{255, 255,   0, 255, 255,   0, 255, 255, },
{255,   0,   0,   0,   0,   0,   0, 255, },
{255, 255,   0, 255, 255,   0, 255, 255, },
{255,   0,   0,   0,   0,   0,   0, 255, },
{255, 255,   0, 255, 255,   0, 255, 255, },
{255,   0,   0,   0,   0,   0,   0, 255, },
{255, 255,   0, 255, 255,   0, 255, 255, },
};
//const uint32_t ladder_palate[] = {
int[] ladder_palate = {
0x805030, 
};
//struct Sprite ladder = {8, 9, &ladder_image[0][0], ladder_palate};
Sprite ladder = new Sprite(8, 9, ladder_image, ladder_palate);

//const uint8_t spider_image[8][8] = {
int[][] spider_image = {
{  0, 255, 255,   0, 255, 255,   0, 255, },
{255,   0, 255,   0, 255,   0, 255, 255, },
{255, 255,   0,   0,   0, 255, 255, 255, },
{255, 255, 255,   0, 255, 255, 255, 255, },
{255, 255,   0,   0,   0, 255, 255, 255, },
{255,   0, 255,   0, 255,   0, 255, 255, },
{  0, 255, 255,   0, 255, 255,   0, 255, },
{255, 255, 255, 255, 255, 255, 255, 255, },
};
//const uint32_t spider_palate[] = {
int[] spider_palate = {
0x808080, 
};
//struct Sprite spider = {8, 8, &spider_image[0][0], spider_palate};
Sprite spider = new Sprite(8, 8, spider_image, spider_palate);

//const uint8_t L_image[8][8] = {
int[][] L_image = {
{255, 255, 255, 255, 255, 255, 255, 255, },
{255, 255,   0, 255, 255, 255, 255, 255, },
{255, 255,   0, 255, 255, 255, 255, 255, },
{255, 255,   0, 255, 255, 255, 255, 255, },
{255, 255,   0, 255, 255, 255, 255, 255, },
{255, 255,   0, 255, 255, 255, 255, 255, },
{255, 255,   0,   0,   0,   0, 255, 255, },
{255, 255, 255, 255, 255, 255, 255, 255, },
};
//const uint32_t L_palate[] = {
int[] L_palate = {
0xFFFFFF, 
};
//struct Sprite L = {8, 8, &L_image[0][0], L_palate};
Sprite L = new Sprite(8, 8, L_image, L_palate);

//const uint8_t less_than_image[8][8] = {
int[][] less_than_image = {
{255, 255, 255, 255, 255, 255, 255, 255,},
{255, 255, 255, 255, 255, 0, 255, 255,},
{255, 255, 255, 255,   0, 255, 255, 255,},
{255, 255, 255,   0, 255, 255, 255, 255,},
{255, 255,   0, 255, 255, 255, 255, 255,},
{255, 255, 255,   0, 255, 255, 255, 255,},
{255, 255, 255, 255,   0, 255, 255, 255,},
{255, 255, 255, 255, 255, 0, 255, 255,},
};
//const uint32_t less_than_palate[] = {
int[] less_than_palate = {
0xFF42DD, 
};
//struct Sprite less_than = {8, 8, &less_than_image[0][0], less_than_palate};
Sprite less_than = new Sprite(8, 8, less_than_image, less_than_palate);
//const uint8_t three_image[8][8] = {
int[][] three_image = {
{255, 255, 255, 255, 255, 255, },
{  0,   0,   0,   0, 255, 255, },
{255, 255, 255,   0, 255, 255, },
{255, 255, 255,   0, 255, 255, },
{  0,   0,   0,   0, 255, 255, },
{255, 255, 255,   0, 255, 255, },
{255, 255, 255,   0, 255, 255, },
{  0,   0,   0,   0, 255, 255, },
};
//const uint32_t three_palate[] = {
int[] three_palate = {
0xFF42DD, 
};
//struct Sprite three = {8, 8, &three_image[0][0], three_palate};
Sprite three = new Sprite(8, 8, three_image, three_palate);

//const uint8_t bat_image[8][8] = {
int[][] bat_image = {
{255,   0,   0,   0,   0,   0, 255, 255, },
{255,   0, 255, 255, 255, 255,   0, 255, },
{255,   0, 255, 255, 255, 255,   0, 255, },
{255,   0, 255,   0,   0,   0, 255, 255, },
{255,   0, 255, 255, 255, 255,   0, 255, },
{255,   0, 255, 255, 255, 255,   0, 255, },
{255,   0, 255, 255, 255, 255,   0, 255, },
{255,   0,   0,   0,   0,   0, 255, 255, },
};
//const uint32_t bat_palate[] = {
int[] bat_palate = {
0xD25B00, 
};
//struct Sprite bat = {8, 8, &bat_image[0][0], bat_palate};
Sprite bat = new Sprite(8, 8, bat_image, bat_palate);