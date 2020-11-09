
float cx = 0, cy = 0;
PImage dvd;
boolean forward_x = false, forward_y = false;
float last_millis = 0;

int[] col = {0, 0, 0};

void setup()
{
  size(1920, 1080);
  background(0);
  stroke(255);
  noFill();
  dvd = loadImage("dvd_video.png");
  randomize_color();
  cx = (int)random(width - dvd.width);
  cy = (int)random(height - dvd.height);
  forward_x = (int)random(1) > 0.5? true: false;
  forward_y = (int)random(1) > 0.5? true: false;
  last_millis = frameRateLastNanos;
}

void draw()
{
  background(0);
  float now = frameRateLastNanos;
  float elapsed_millis = now - last_millis;
  last_millis = now;
  float quanta = elapsed_millis/ 1000000.0;
  cx = forward_x? cx + quanta :cx - quanta;
  //cy = forward_y? cy+1 :cy-1;
  
  // Check for collision
  if (cx < 0)
  {
    cx = 0;
    forward_x = !forward_x;
    randomize_color();
  }
  else if (cx + dvd.width > width)
  {
    cx = width - dvd.width;
    forward_x = !forward_x;
    randomize_color();
  }
  image(dvd, cx, cy);
}

void randomize_color()
{
  float t = random(2);
  if (t < 1) // one strong color
  {
    int strong_col = (int)random(3);
    col[strong_col] = (int)random(100, 200);
    col[(strong_col + 1) % 3] = (int)random(10, 80);
    col[(strong_col + 2) % 3] = (int)random(10, 80);
  }
  else // one weak color
  {
    int weak_col = (int)random(3);
    col[weak_col] = (int)random(10, 80);
    col[(weak_col + 1) % 3] = (int)random(100, 200);
    col[(weak_col + 2) % 3] = (int)random(100, 200);
  }
  tint(col[0], col[1], col[2]);
}
