import java.awt.event.KeyEvent;

class Buttons {
  boolean u1 = false;
  boolean d1 = false;
  boolean l1 = false;
  boolean r1 = false;
  boolean y1 = false;
  boolean a1 = false;
  boolean x1 = false;
  boolean b1 = false;
  boolean u2 = false;
  boolean d2 = false;
  boolean l2 = false;
  boolean r2 = false;
  boolean y2 = false;
  boolean a2 = false;
  boolean x2 = false;
  boolean b2 = false;

  private boolean u1Prev = false, d1Prev = false, l1Prev = false, r1Prev = false, y1Prev = false, a1Prev = false, x1Prev = false, b1Prev = false;  
  private boolean u2Prev = false, d2Prev = false, l2Prev = false, r2Prev = false, y2Prev = false, a2Prev = false, x2Prev = false, b2Prev = false;  

  boolean anykey(){return (u1 || d1 || l1 || r1 || y1 || a1 || x1 || b1 || u2 || d2 || l2 || r2 || y2 || a2 || x2 || b2);}

boolean u1Pressed(){
    if(u1)
    {
        if(!u1Prev)
        {
            u1Prev=true;
            return(true);
        }
    }
    else
    {
        u1Prev=false;
    }
    return(false);
}
  boolean d1Pressed(){if(d1){if(!d1Prev){d1Prev=true;return(true);}}else{d1Prev=false;}return(false);}
  boolean l1Pressed(){if(l1){if(!l1Prev){l1Prev=true;return(true);}}else{l1Prev=false;}return(false);}
  boolean r1Pressed(){if(r1){if(!r1Prev){r1Prev=true;return(true);}}else{r1Prev=false;}return(false);}
  boolean y1Pressed(){if(y1){if(!y1Prev){y1Prev=true;return(true);}}else{y1Prev=false;}return(false);}
  boolean a1Pressed(){if(a1){if(!a1Prev){a1Prev=true;return(true);}}else{a1Prev=false;}return(false);}
  boolean x1Pressed(){if(x1){if(!x1Prev){x1Prev=true;return(true);}}else{x1Prev=false;}return(false);}
  boolean b1Pressed(){if(b1){if(!b1Prev){b1Prev=true;return(true);}}else{b1Prev=false;}return(false);}

  boolean u2Pressed(){if(u2){if(!u2Prev){u2Prev=true;return(true);}}else{u2Prev=false;}return(false);}
  boolean d2Pressed(){if(d2){if(!d2Prev){d2Prev=true;return(true);}}else{d2Prev=false;}return(false);}
  boolean l2Pressed(){if(l2){if(!l2Prev){l2Prev=true;return(true);}}else{l2Prev=false;}return(false);}
  boolean r2Pressed(){if(r2){if(!r2Prev){r2Prev=true;return(true);}}else{r2Prev=false;}return(false);}
  boolean y2Pressed(){if(y2){if(!y2Prev){y2Prev=true;return(true);}}else{y2Prev=false;}return(false);}
  boolean a2Pressed(){if(a2){if(!a2Prev){a2Prev=true;return(true);}}else{a2Prev=false;}return(false);}
  boolean x2Pressed(){if(x2){if(!x2Prev){x2Prev=true;return(true);}}else{x2Prev=false;}return(false);}
  boolean b2Pressed(){if(b2){if(!b2Prev){b2Prev=true;return(true);}}else{b2Prev=false;}return(false);}
} 

Buttons buttons = new Buttons(); 


void keyPressed()
{
  switch (key)
  {
    case 'w': buttons.u1 = true; break;
    case 's': buttons.d1 = true; break;
    case 'a': buttons.l1 = true; break;
    case 'd': buttons.r1 = true; break;
    case 'i': buttons.y1 = true; break;
    case 'k': buttons.a1 = true; break;
    case 'j': buttons.x1 = true; break;
    case 'l': buttons.b1 = true; break;

    case '5': buttons.y2 = true; break;
    case '1': buttons.a2 = true; break;
    case '2': buttons.x2 = true; break;
    case '3': buttons.b2 = true; break;

    case CODED:
      switch (keyCode)
      {
        case KeyEvent.VK_UP:       buttons.u2 = true; break;
        case KeyEvent.VK_DOWN:     buttons.d2 = true; break;
        case KeyEvent.VK_LEFT:     buttons.l2 = true; break;
        case KeyEvent.VK_RIGHT:    buttons.r2 = true; break;
        case KeyEvent.VK_KP_UP:    buttons.y2 = true; break;
        case KeyEvent.VK_KP_DOWN:  buttons.a2 = true; break;
        case KeyEvent.VK_KP_LEFT:  buttons.x2 = true; break;
        case KeyEvent.VK_KP_RIGHT: buttons.b2 = true; break;
      }
    break;    
  }
}

void keyReleased()
{
  switch (key)
  {
    case 'w': buttons.u1 = false; break;
    case 's': buttons.d1 = false; break;
    case 'a': buttons.l1 = false; break;
    case 'd': buttons.r1 = false; break;
    case 'i': buttons.y1 = false; break;
    case 'k': buttons.a1 = false; break;
    case 'j': buttons.x1 = false; break;
    case 'l': buttons.b1 = false; break;

    case '5': buttons.y2 = false; break;
    case '1': buttons.a2 = false; break;
    case '2': buttons.x2 = false; break;
    case '3': buttons.b2 = false; break;
    case CODED:
      switch (keyCode)
      {
        case KeyEvent.VK_UP:       buttons.u2 = false; break;
        case KeyEvent.VK_DOWN:     buttons.d2 = false; break;
        case KeyEvent.VK_LEFT:     buttons.l2 = false; break;
        case KeyEvent.VK_RIGHT:    buttons.r2 = false; break;
        case KeyEvent.VK_KP_UP:    buttons.y2 = false; break;
        case KeyEvent.VK_KP_DOWN:  buttons.a2 = false; break;
        case KeyEvent.VK_KP_LEFT:  buttons.x2 = false; break;
        case KeyEvent.VK_KP_RIGHT: buttons.b2 = false; break;
      }
      break;    
  }
}


public class Sprite
{
  public int width;
  public int height;
  public int[][] image;
  public int[] palate;
  public Sprite(
    int width,
    int height,
    int[][] image,
    int[] palate)
  {
    this.width = width;
    this.height = height;
    this.image = image;    
    this.palate = palate;
  }
};

void DrawSprite(Sprite sprite, int x, int y, boolean mirror)
{
  int row, col;
  int firstrow, lastrow;
  int firstcol, lastcol;
  int palateindex;

  if (y < 0)
    firstrow = -y;
  else
    firstrow = 0;

  if (x < 0)
    firstcol = -x;
  else
    firstcol = 0;

  if (y + sprite.height >= leds.rows)
    lastrow = leds.rows - y;
  else
    lastrow = sprite.height;
    
  if (x + sprite.width >= leds.cols)
    lastcol = leds.cols - x;
  else
    lastcol = sprite.width;

  for (row = firstrow; row < lastrow; row++)
  {
    for (col = firstcol; col < lastcol; col++)
    {
      if (mirror)
      {
        palateindex = sprite.image[row][sprite.width - col - 1];
      }
      else
      {
        palateindex = sprite.image[row][col];
      }
      if (palateindex != 255)
      {
        leds.setPixelXY(x + col, y + row, sprite.palate[palateindex]);
      }
    }
  }
}

boolean CollisionCoarse(Sprite s1, int x1, int y1, boolean mirror1, Sprite s2, int x2, int y2, boolean mirror2)
{
  if (x2 < x1 + s1.width &&
      x2 + s1.width > x1 &&
      y2 < y1 + s1.height &&
      s2.height + y2 > y1)
    return true;
  else
    return false;
}

boolean CollisionFine(Sprite s1, int x1, int y1, boolean mirror1, Sprite s2, int x2, int y2, boolean mirror2)
{
  int row1, col1;
  int row2, col2;
  int rowfrom1, colfrom1, rowto1, colto1;
  int rowfrom2, colfrom2;
  int color1, color2;

  if (!CollisionCoarse(s1, x1, y1, mirror1, s2, x2, y2, mirror2))
    return false;
  
  if (x1 > x2)
  {  
    colfrom1 = 0;
    colfrom2 = x1 - x2;
    colto1 = Math.min(s1.width - 1, colfrom1 + s2.width - colfrom2 - 1);
  }
  else
  { 
    colfrom2 = 0;
    colfrom1 = x2 - x1;
    colto1 = Math.min(s1.width - 1, colfrom1 + s2.width - colfrom2 - 1);
  }

  if (y1 > y2)
  {
    rowfrom1 = 0;
    rowfrom2 = y1 - y2;
    rowto1 = Math.min(s1.height - 1, rowfrom1 + s2.height - rowfrom2 - 1);
  }
  else
  { 
    rowfrom2 = 0;
    rowfrom1 = y2 - y1;
    rowto1 = Math.min(s1.height - 1, rowfrom1 + s2.height - rowfrom2 - 1);
  }

  //print(x1 + " " + x2 + " " + colfrom1 + " " + colto1 + " " + colfrom2 + " | ");
  //println(y1 + " " + y2 + " " + rowfrom1 + " " + rowto1 + " " + rowfrom2);

  for (row1 = rowfrom1, row2 = rowfrom2; row1 <= rowto1; row1++, row2++)
  {
    for (col1 = colfrom1, col2 = colfrom2; col1 <= colto1; col1++, col2++)
    {
      if (mirror1)
      {
        color1 = s1.image[row1][s1.width - col1 - 1];
      }
      else
      {
        color1 = s1.image[row1][col1];
      }
      if (mirror2)
      {
        color2 = s2.image[row2][s2.width - col2 - 1];
      }
      else
      {
        color2 = s2.image[row2][col2];
      }
      if (color1 != 255 && color2 != 255)
      {
        return true;
      }
    }
  }
  return false;
}

void DrawNumber(int number, int x, int y, int rgbcolor, boolean rjust)
{
  int digit;
  int divisor;
  int mask;
  int row;
  int col;
  boolean gotnonzerodigit = false;
  int[] numbers = {0x7b6f,0x2c92,0x73e7,0x73cf,0x5bc9,0x79cf,0x79ef,0x7a49,0x7bef,0x7bcf};
  
  if (number < 0)
   number = -number;
  else if (number > 99999)
   number = 0;
  for (divisor = 10000; divisor > 0; divisor /= 10)
  {
    digit = number / divisor;
    if (digit != 0 || gotnonzerodigit == true || divisor == 1)
    {
      gotnonzerodigit = true;
      mask = 0x4000;
      for (row = 0; row < 5; row++)
      {        
        for (col = 0; col < 3; col++, mask >>= 1)
        {
          if ((numbers[digit] & mask) != 0) 
            leds.setPixelXY(x + col, y + row, rgbcolor);
        }
      }
      x += 4;
    }
    else if (rjust)
    {
      x += 4;
    }
    number -= digit * divisor;
  }
}

void DrawBackground(int[] from)
{  
  for (int ix = 0; ix < 1920; ix++)
  {
    leds.setPixel(ix, from[ix]);
  }
}

void DrawLine(int x1, int y1, int x2, int y2, int c)
{
 int x,y,dx,dy,dx1,dy1,px,py,xe,ye,i;
 dx=x2-x1;
 dy=y2-y1;
 dx1=abs(dx);
 dy1=abs(dy);
 px=2*dy1-dx1;
 py=2*dx1-dy1;
 if(dy1<=dx1)
 {
  if(dx>=0)
  {
   x=x1;
   y=y1;
   xe=x2;
  }
  else
  {
   x=x2;
   y=y2;
   xe=x1;
  }
  leds.setPixelXY(x, y, c);
  for(i=0;x<xe;i++)
  {
   x=x+1;
   if(px<0)
   {
    px=px+2*dy1;
   }
   else
   {
    if((dx<0 && dy<0) || (dx>0 && dy>0))
    {
     y=y+1;
    }
    else
    {
     y=y-1;
    }
    px=px+2*(dy1-dx1);
   }
   leds.setPixelXY(x, y, c);
  }
 }
 else
 {
  if(dy>=0)
  {
   x=x1;
   y=y1;
   ye=y2;
  }
  else
  {
   x=x2;
   y=y2;
   ye=y1;
  }
  leds.setPixelXY(x, y, c);
  for(i=0;y<ye;i++)
  {
   y=y+1;
   if(py<=0)
   {
    py=py+2*dx1;
   }
   else
   {
    if((dx<0 && dy<0) || (dx>0 && dy>0))
    {
     x=x+1;
    }
    else
    {
     x=x-1;
    }
    py=py+2*(dx1-dy1);
   }
   leds.setPixelXY(x, y, c);
  }
 }
}

void DrawRect(int x1, int y1, int x2, int y2, int c)
{
  for (int row = y1; row < y2; row++)
    for (int col = x1; col < x2; col++)
     leds.setPixelXY(col, row, c);
}

void DrawElipse(int ox, int oy, int rx, int ry, int c)
{
  int ry2 = ry * ry;
  int rx2 = rx * rx;
  int ry2rx2 = ry2 * rx2;
  int x0 = rx;
  int dx = 0;
  
  for (int x = -rx; x <= rx; x++)
    leds.setPixelXY(ox + x, oy, c);
  for (int y = 1; y <= ry; y++)
  {
    int x1 = x0 - (dx - 1);
    for ( ; x1 > 0; x1--)
      if (x1 * x1 * ry2 + y * y * rx2 < ry2rx2)
        break;
    dx = x0 - x1;
    x0 = x1;
    for (int x = -x0; x <= x0; x++)
    {
      leds.setPixelXY(ox + x, oy - y, c);
      leds.setPixelXY(ox + x, oy + y, c);
    }
  }
}

void ClearScreen()
{
  for (int ix = 0; ix < 1920; ix++)
  {
    leds.drawBuffer[ix] = 0;
  }
}
