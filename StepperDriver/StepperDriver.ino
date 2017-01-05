#define SPEED_POT_PIN A0
#define STEP_CLK_PIN 13

// Input pins for limit switches should be PCINT pins internally pulled up to +5V.
// Min X axis limit switch
// Max X axis limit switch
// Min Y axis limit switch
// Max Y axis limit switch

unsigned long start = 0;

void setup() {
  pinMode(STEP_CLK_PIN, OUTPUT);
}

void loop() {
  unsigned int halprd = analogRead(SPEED_POT_PIN);
  
  digitalWrite(STEP_CLK_PIN, LOW);
  start = micros(); while(micros() < start + halprd);
  
  digitalWrite(STEP_CLK_PIN, HIGH);
  start = micros(); while(micros() < start + halprd);
}
