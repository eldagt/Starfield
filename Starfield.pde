Particle[] parts = new Particle[1000];

void setup(){
  size(500, 500);
  noStroke();

  // Initialize all particles as regular Particle objects
  for (int i = 0; i < parts.length; i++) {
    if (i == 0) {
      // The first particle is an OddballParticle
      parts[i] = new OddballParticle();
    } else {
      // All other particles are normal Particles
      parts[i] = new Particle();
    }
  }
}

void draw(){
  background(0);  // Clear the screen each frame

  for (int i = 0; i < parts.length; i++) {
    parts[i].show();  // Display the particle
    parts[i].drift();  // Move the particle
  }
}

// Regular Particle class
class Particle {
  float myX, myY;
  float mySpeed;
  color myColor;

  // Particle constructor
  Particle() {
    myX = random(width);  // Random start position
    myY = random(height);  // Random start position
    mySpeed = random(1, 3);  // Random speed
    myColor = color(random(255), random(255), random(255));  // Random color
  }

  // Show the particle on the screen (circle with random size)
  void show() {
    fill(myColor);
    float size = random(5, 15); // Random size for variety
    ellipse(myX, myY, size, size);  // Draw a circle with random size
  }

  // Drift the particle (move randomly)
  void drift() {
    myX += random(-mySpeed, mySpeed);  // Move randomly in X
    myY += random(-mySpeed, mySpeed);  // Move randomly in Y

    // Wrap around the screen edges
    if (myX > width) myX = 0;
    if (myX < 0) myX = width;
    if (myY > height) myY = 0;
    if (myY < 0) myY = height;
  }
}

// OddballParticle class (inherits from Particle)
class OddballParticle extends Particle {

  // Oddball constructor with different color
  OddballParticle() {
    myX = random(width);  // Random start position
    myY = random(height);  // Random start position
    myColor = color(0, 255, 0);  // Green color for Oddball
    mySpeed = 2;  // Slower speed
  }

  // Override the show method to display a star instead of a circle
  @Override
  void show() {
    fill(myColor);
    drawStar(myX, myY, 15, 25, 5);  // Draw a star instead of a circle
  }

  // Override the drift method to follow the mouse in a jittery fashion
  @Override
  void drift() {
    myX += random(-1, 1);  // Move randomly around the mouse
    myY += random(-1, 1);  // Move randomly around the mouse

    // Follow the mouse directly with some randomness
    myX += (mouseX - myX) * 0.05;  // Slowly move toward mouseX
    myY += (mouseY - myY) * 0.05;  // Slowly move toward mouseY

    // Add boundaries to keep the Oddball inside the canvas
    if (myX > width) myX = width;
    if (myX < 0) myX = 0;
    if (myY > height) myY = height;
    if (myY < 0) myY = 0;
  }

  // Function to draw a star at a given position with a certain size
  void drawStar(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle / 2.0;
    beginShape();
    for (float a = -PI / 2; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a + halfAngle) * radius1;
      sy = y + sin(a + halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}
