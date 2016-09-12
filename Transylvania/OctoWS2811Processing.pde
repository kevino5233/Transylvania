/*  OctoWS2811 LED Display Library Emulator For Processing
    Copyright (c) 2016 Mickey Delp, Delptronics


	OctoWS2811 - High Performance WS2811 LED Display Library
    http://www.pjrc.com/teensy/td_libs_OctoWS2811.html
    Copyright (c) 2013 Paul Stoffregen, PJRC.COM, LLC

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
*/


class OctoWS2811 {
	private	int stripLen;
	private	int rows;
	private	int cols;
	private	int[] drawBuffer;
	private	byte params;

	OctoWS2811(int numPerStrip, int numPerRow)
	{
		stripLen = numPerStrip;
		cols = numPerRow;
		rows = 8 * numPerStrip / numPerRow;
		drawBuffer = new int[stripLen * 8];
	}

	void begin()
	{
		noStroke();
	}

	//void setPixelr(int num, byte ar, byte ge, byte be)
	//{
	//	setPixel(num, (ar << 16) | (ge << 8) | be);
	//}

  void setPixelXY(int x, int y, int rgbcolor)
  {
    if ((y & 1) == 0) {
      drawBuffer[y * cols + x] = rgbcolor | 0xFF000000;
    } else {
      drawBuffer[y * cols + cols - 1 - x] = rgbcolor | 0xFF000000;
    }
  }

	void setPixel(int num, int rgbcolor)
	{
		drawBuffer[num] = rgbcolor | 0xFF000000;
	}

	int getPixel(int num)
	{
		return drawBuffer[num] & 0x00FFFFFF;
	}

	void show()
	{
		int num = 0, row, col, y;

    for (row = 1; row <= rows; row++)
		{
      y = row * 15;
			if ((row & 1) == 1) // even
			{
				for (col = 1; col <= cols; col++, num++)
				{
          fill(adjustBrightness(drawBuffer[num]));
          ellipse(col * 15, y, 9, 9);
        }
      }
      else // odd
      {
        for (col = cols; col > 0; col--, num++)
        {
          fill(adjustBrightness(drawBuffer[num]));
          ellipse(col * 15, y, 9, 9);
        }
      }
    }
  }


  int busy()
  {
    return 0;
  }

  int numPixels() 
  {
    return stripLen * 8;
  }

  int adjustBrightness(int color1) 
  {
    int[] color2 = {0,2,5,8,11,14,17,20,23,26,28,31,34,37,39,42,45,47,50,52,55,57,60,62,65,67,70,72,75,77,79,82,84,86,89,91,93,95,97,100,102,104,106,108,110,112,114,116,118,120,122,124,126,128,130,131,133,135,137,139,140,142,144,146,147,149,151,152,154,156,157,159,160,162,163,165,166,168,169,171,172,173,175,176,178,179,180,182,183,184,185,187,188,189,190,192,193,194,195,196,197,198,199,200,202,203,204,205,206,207,208,209,210,210,211,212,213,214,215,216,217,217,218,219,220,221,221,222,223,224,224,225,226,227,227,228,229,229,230,230,231,232,232,233,233,234,235,235,236,236,237,237,238,238,239,239,240,240,240,241,241,242,242,243,243,243,244,244,244,245,245,245,246,246,246,247,247,247,247,248,248,248,249,249,249,249,249,250,250,250,250,250,251,251,251,251,251,251,252,252,252,252,252,252,252,253,253,253,253,253,253,253,253,253,253,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,254,255};
    int r, g, b;
    r = color2[(color1 & 0xff0000) >> 16];
    g = color2[(color1 & 0x00ff00) >> 8];
    b = color2[(color1 & 0x0000ff)];
    return (0xFF000000 | r<<16 | g<<8 | b);
  }

};