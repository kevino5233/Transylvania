import java.util.Comparator;
import java.util.Arrays;
import java.util.List;
// Converts images (png, gif, bmp, jpg) into sprite and background code
// for use with the LED Matrix

void setup() 
{
  // windows
  ConvertSprite("D:/Documents/Transylvania/Transylvania Assets/L.png", "L");
  ConvertSprite("D:/Documents/Transylvania/Transylvania Assets/less_than.png", "less_than");
  
  // mac
  // ConvertSprite("/Users/kevino/Documents/LED Matrix/Transylvania Assets/spider.png", "spider");
  
  //ConvertSpriteGroup("C:/LED Matrix/SDB Assets", "balls0.png,balls1.png,balls2.png,balls3.png,balls4.png,balls5.png", "balls");
  
  //ConvertBackground("C:/LED Matrix/SDB Assets/sdb-splash.png", "splash", false);

  exit();
}



void ConvertSprite(String filename, String varname)
{
  PImage pic;
  int row, col, pixel, ix;
  int palateCount = 0;
  int[] palate = new int[256];

  pic = loadImage(filename);
  pic.loadPixels();
  
  println("//const uint8_t " + varname + "_image[" + pic.height + "][" + pic.width + "] = {");
  println("int[][] " + varname + "_image = {");
  for (row = 0; row < pic.height; row++)
  {
    print("{");
    for (col = 0; col < pic.width; col++)
    {
      pixel = pic.pixels[col + row * pic.width];
      if ((pixel & 0xFF000000) == 0)
      {
        print("255, ");
      }
      else
      {
        int color1 = pixel & 0x00FFFFFF;
        for (ix = 0; ix < palateCount; ix++)
        {
          if (color1 == palate[ix])
            break;
        }
        if (ix >= palateCount && ix < 255)
        {
          palate[ix] = color1;
          palateCount++;
        }
        print("   ".substring(str(ix).length()) + str(ix) + ", ");
      }
    }
    println("},");
  }
  println("};");
  println("//const uint32_t " + varname + "_palate[] = {");
  println("int[] " + varname + "_palate = {");
  for (ix = 0; ix < palateCount; ix++)
  {
    print("0x" + hex(palate[ix], 6) + ", ");
  }
  println("");
  println("};");
  println("//struct Sprite " + varname + " = {" + pic.width + ", " + pic.height + ", &" + varname + "_image[0][0], " + varname + "_palate};");
  println("Sprite " + varname + " = new Sprite(" + pic.width + ", " + pic.height + ", " + varname + "_image, " + varname + "_palate);");
  println("");

}

void ConvertSpriteGroup(String directory, String filenames, String groupName)
{
  PImage pic;
  int row, col, ix, pixel;
  Integer[] palate = new Integer[256];
  int palateCount = 0;
  List<String> spriteNames = new ArrayList<String>();
  List<Integer> picWidth = new ArrayList<Integer>();
  List<Integer> picHeight = new ArrayList<Integer>();

  for (ix = 0; ix < 256; ix++)
  {
   palate[ix] = 0xFFFFFFFF; 
  }
  for (String name : filenames.split(","))
  {
    if (name == "")
      break;
    pic = loadImage(directory + "/" + name);
    pic.loadPixels();
    for (row = 0; row < pic.height; row++)
    {
      for (col = 0; col < pic.width; col++)
      {
        pixel = pic.pixels[col + row * pic.width];
        if ((pixel & 0xFF000000) != 0)
        {
          int color1 = pixel & 0x00FFFFFF;
          for (ix = 0; ix < palateCount; ix++)
          {
            if (color1 == palate[ix])
              break;
          }
          if (ix >= palateCount && ix < 255)
          {
            palate[ix] = color1;
            palateCount++;
          }
        }
      }
    }
  }
  Arrays.sort(palate, new Comparator<Integer>() {
    public int compare(Integer c1, Integer c2) {
      int c1brightness = ((c1 & 0xFF0000) >> 16) + ((c1 & 0x00FF00) >> 8) + (c1 & 0x0000FF);
      int c2brightness = ((c2 & 0xFF0000) >> 16) + ((c2 & 0x00FF00) >> 8) + (c2 & 0x0000FF);
      if (c1brightness == c2brightness)
        return 0;
      else if (c1brightness < c2brightness)
        return -1;
      else
        return 1;
    }
  });

  for (String name : filenames.split(","))
  {
    if (name == "")
      break;
    pic = loadImage(directory + "/" + name);
    pic.loadPixels();
    name = name.substring(0, name.lastIndexOf('.')).replaceAll(" ", "_");;
    spriteNames.add(name);
    picWidth.add(pic.width);
    picHeight.add(pic.height);
    println("//const uint8_t " + name + "_image[" + pic.height + "][" + pic.width + "] = {");
    println("int[][] " + name + "_image = {");
    for (row = 0; row < pic.height; row++)
    {
      print("{");
      for (col = 0; col < pic.width; col++)
      {
        pixel = pic.pixels[col + row * pic.width];
        if ((pixel & 0xFF000000) == 0)
        {
          print("255, ");
        }
        else
        {
          int color1 = pixel & 0x00FFFFFF;
          for (ix = 0; ix < palateCount; ix++)
          {
            if (color1 == palate[ix])
              break;
          }
          print("   ".substring(str(ix).length()) + str(ix) + ", ");
        }
      }
      println("},");
    }
    println("};");
    println("");
  }

  println("//const uint32_t " + groupName + "_palate[] = {");
  println("int[] " + groupName + "_palate = {");
  for (ix = 0; ix < palateCount; ix++)
  {
    print("0x" + hex(palate[ix], 6) + ", ");
  }
  println("");
  println("};");
  println("");

  println("int " + groupName + "SpriteCount = " + spriteNames.size() + ";");
  println("");
  
  println("Sprite " + groupName + "Sprite[] = {");
  for (ix = 0; ix < spriteNames.size(); ix++)
  {
    println("  new Sprite(" + picWidth.get(ix) + ", " + picHeight.get(ix) + ", " + spriteNames.get(ix) + "_image, " + groupName + "_palate),");
  }
  println("};");

  println("/*");
  println("struct Sprite " + groupName + "Sprite[" + spriteNames.size() + "] = {");
  for (ix = 0; ix < spriteNames.size(); ix++)
  {
    println("  {" + picWidth.get(ix) + ", " + picHeight.get(ix) + ", &" + spriteNames.get(ix) + "_image[0][0], " + groupName + "_palate},");
  }
  println("};");
  println("*/");
}
    
void ConvertBackground(String filename, String varname, Boolean includeArduino)
{
  int cols = 60, rows = 32;
  ColorFormat format = ColorFormat.GRB;

  PImage pic;
  int row, col, pixel;
  int rowsPerStrip = rows / 8;
  int incdec, stopcol;
  String[] colors = new String[8];
  String[] colorByte = new String[8];


  pic = loadImage(filename);
  pic.loadPixels();

  if (pic.height < rows || pic.width < cols)
  {
    println("//ERROR: " + varname + " (" + pic.width + "x" + pic.height + ") is smaller than " + cols + "x" + rows);
    return;
  }
  println("//const uint32_t " + varname + "_background[] = {");
  println("int[] " + varname + "_background = {");
  for (row = 0; row < rows; row++)
  {
    for (col = 0; col < cols; col++)
    {
      pixel = pic.pixels[col + row * pic.width] & 0x00FFFFFF;
      print("0x" + hex(pixel, 6) + ", ");
    }
    println("");
    row++;
    for (col = cols - 1; col >= 0; col--)
    {
      pixel = pic.pixels[col + row * pic.width] & 0x00FFFFFF;
      print("0x" + hex(pixel, 6) + ", ");
    }
    println("");
  }
  println("};");
  println("");

  if (includeArduino)
  {
    println("const uint8_t " + varname + "_buffer[] = {");
    for (row = 0; row < rowsPerStrip; row++)
    {
      if ((row & 1) == 0)
      {
        incdec = 1;
        col = 0;
        stopcol = cols;
      }
      else
      {
        incdec = -1;
        col = cols - 1;
        stopcol = -1;
      }
      for (; col != stopcol; col += incdec)
      {
        colors[0] = binary(ConvertColor(pic.pixels[col + pic.width * (row)], format), 24);
        colors[1] = binary(ConvertColor(pic.pixels[col + pic.width * (row + rowsPerStrip)], format), 24);
        colors[2] = binary(ConvertColor(pic.pixels[col + pic.width * (row + rowsPerStrip * 2)], format), 24);
        colors[3] = binary(ConvertColor(pic.pixels[col + pic.width * (row + rowsPerStrip * 3)], format), 24);
        colors[4] = binary(ConvertColor(pic.pixels[col + pic.width * (row + rowsPerStrip * 4)], format), 24);
        colors[5] = binary(ConvertColor(pic.pixels[col + pic.width * (row + rowsPerStrip * 5)], format), 24);
        colors[6] = binary(ConvertColor(pic.pixels[col + pic.width * (row + rowsPerStrip * 6)], format), 24);
        colors[7] = binary(ConvertColor(pic.pixels[col + pic.width * (row + rowsPerStrip * 7)], format), 24);
        for (int colorBit = 0; colorBit < 24; colorBit++)
        {
          for (int stringNum = 0; stringNum < 8; stringNum++)
          {
            colorByte[7 - stringNum] = colors[stringNum].substring(colorBit, colorBit + 1);
          }
          print(unbinary(colorByte[0]+colorByte[1]+colorByte[2]+colorByte[3]+colorByte[4]+colorByte[5]+colorByte[6]+colorByte[7]) + ", ");
        }
        println("");
      }
    }
    println("};");
    println("");
  }  
}

enum ColorFormat {RGB, RBG, GRB, GBR};

int ConvertColor(int color1, ColorFormat format)
{
  if (format == ColorFormat.RBG)
    return (color1 & 0xFF0000) | ((color1 & 0x0000FF) << 8) | ((color1 & 0x00FF00) >> 8);
  else if (format == ColorFormat.GRB)
    return ((color1 & 0x00FF00) << 8) | ((color1 & 0xFF0000) >> 8) | (color1 & 0x0000FF);
  else if (format == ColorFormat.GBR)
    return ((color1 & 0x00FFFF) << 8) | ((color1 & 0xff0000) >> 16);
  else // RGB
    return color1;  
}