#include <ESP32Servo.h>  // Include the servo library
#include <WiFi.h> 
#include <FirebaseESP32.h>


// Constants for Stepper Motor
const int stepperPins[] = {12, 14, 27, 26};  // IN1, IN2, IN3, IN4
const int button1Pin = 4;                    // Button for 90-degree forward rotation
const int button3Pin = 5;                    // Button for 180-degree reverse rotation
const int stepsPer180Deg = 2048;             // Steps for a 180-degree turn (adjust as needed)

// Constants for Servo Motor
const int servoPin = 18;                     // Pin for first servo motor
const int secondServoPin = 22;               // Pin for second servo motor
const int button2Pin = 15;                   // Button to toggle first servo between 0 and 180 degrees
const int button4Pin = 21;                   // Button to rotate first servo back to 0 degrees

// LED and button for LED control
const int ledPin = 13;
const int ledPin1 = 32;
const int ledPin2 = 33;
const int ledPin3 = 23;
const int ledPin4 = 2;                       // Pin for LED
const int ledButtonPin = 19;                 // Button to turn LED on and control second servo

// IR Sensor
const int irSensorPin = 25;                  // Pin for IR sensor (OUT pin)

// Servo objects
Servo myServo;
Servo secondServo;

// Button States
bool button1Pressed = false;
bool button2Pressed = false;
bool button3Pressed = false;
bool button4Pressed = false;
bool ledButtonPressed = false;               // LED button state

// Toggle state for first servo
bool isServoAt180 = false;  // Keeps track of the servo's current position

// Stepper motor sequence for a 4-phase motor (half-step mode for smoother operation)
int stepperSequence[8][4] = {
  {1, 0, 0, 0},
  {1, 1, 0, 0},
  {0, 1, 0, 0},
  {0, 1, 1, 0},
  {0, 0, 1, 0},
  {0, 0, 1, 1},
  {0, 0, 0, 1},
  {1, 0, 0, 1}
};

int currentStep = 0;

  FirebaseConfig config;
  FirebaseAuth auth;

 //Firebase Data object
 FirebaseData firebaseData;

 const char* ssid = "PLDTHOMEFIBRbc368";
 const char* password = "PLDTWIFI9xczf";

 //Firebase Host and Token
 const char* firebaseHost = "autopick-51616-default-rtdb.firebaseio.com";
 const char* firebaseToken = "bkBqRvGGiU4RZ2wt3hiohpGDUOraTkrRUZZGjSWo";

void setup() {
 Serial.begin(115200);  // Start the serials communication
 delay(100); 
  
  // Connecting to Wi-Fi
   Serial.println("Connecting to Wi-Fi...");
   WiFi.begin(ssid, password);

  // Wait for the connection to establish
   while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting...");
   }

   Serial.println("Connected to Wi-Fi!");
   Serial.print("IP Address: ");
   Serial.println(WiFi.localIP());  

    // Configure Firebase
    config.host = firebaseHost;
    config.signer.tokens.legacy_token = firebaseToken;


    // Initialize Firebase
   Firebase.begin(&config, &auth);
   Firebase.reconnectWiFi(true);

    // Test Firebase connection in setup()
 if (Firebase.setString(firebaseData, "/test", "Connection Successful")) {
      //TODO : MUST GET ANY DATA FROM FIREBASE
     Serial.println("Firebase connected and data written!");
 } else {
     Serial.print("Firebase connection failed: ");
     Serial.println(firebaseData.errorReason());
 }

  // Setup pins for stepper motor
  for (int i = 0; i < 4; i++) {
    pinMode(stepperPins[i], OUTPUT);
    digitalWrite(stepperPins[i], LOW);
  }

  // Set up buttons
  pinMode(button1Pin, INPUT_PULLUP);
  pinMode(button2Pin, INPUT_PULLUP);
  pinMode(button3Pin, INPUT_PULLUP);
  pinMode(button4Pin, INPUT_PULLUP);
  pinMode(ledButtonPin, INPUT_PULLUP);

  // Set up IR sensor
  pinMode(irSensorPin, INPUT);

  // Set up servo motors
  myServo.attach(servoPin);
  myServo.write(0);  // Start first servo at 0 degrees

  secondServo.attach(secondServoPin);
  secondServo.write(0);  // Start second servo at 0 degrees

  // Set up LED
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW); // Start with LED off
  pinMode(ledPin1, OUTPUT);
  digitalWrite(ledPin1, LOW);
  pinMode(ledPin2, OUTPUT);
  digitalWrite(ledPin2, LOW);
  pinMode(ledPin3, OUTPUT);
  digitalWrite(ledPin3, LOW);
  pinMode(ledPin4, OUTPUT);
  digitalWrite(ledPin4, LOW);

  Serial.begin(115200); // Start serial communication
}

void loop() {
    static unsigned long lastCheck = 0;
   const unsigned long checkInterval = 10000; // Check every 10 seconds

   if (millis() - lastCheck > checkInterval) {
     lastCheck = millis();
     if (WiFi.status() == WL_CONNECTED) {
       Serial.println("Wi-Fi is connected.");
     } else {
       Serial.println("Wi-Fi is not connected. Attempting to reconnect...");
       WiFi.begin(ssid, password); // Reconnect attempt
     }
   }

   if (millis() - lastCheck > checkInterval) {
   lastCheck = millis();

   // Check Firebase connection 
 if (Firebase.getString(firebaseData, "/test")) {
     Serial.println("Firebase is connected.");
      Serial.print("Database says: ");
     Serial.println(firebaseData.stringData());
 } else {
     Serial.println("Failed to read from Firebase.");
     Serial.print("Reason: ");
     Serial.println(firebaseData.errorReason());
 }


  // Check IR sensor
  if (digitalRead(irSensorPin) == LOW) {  // No motion detected
    Serial.println("Wardrobe Empty");
  }

  // Check button1 for stepper motor 90-degree forward rotation
  if (digitalRead(button1Pin) == LOW && !button1Pressed) {
    myServo.write(0);
    delay(3);
    rotateStepper(stepsPer180Deg / 2, true); // Forward
    button1Pressed = true;
  }
  if (digitalRead(button1Pin) == HIGH) {
    button1Pressed = false;
  }

  // Check button2Pin to toggle servo position between 0 and 180 degrees
  if (digitalRead(button2Pin) == LOW && !button2Pressed) {
    if (isServoAt180) {
      myServo.write(0);  // Rotate to 0 degrees
      Serial.println("Rotating first servo to 0 degrees");
    } else {
      myServo.write(180);  // Rotate to 180 degrees
      Serial.println("Rotating first servo to 180 degrees");
    }
    isServoAt180 = !isServoAt180;  // Toggle the state
    button2Pressed = true;
  }
  if (digitalRead(button2Pin) == HIGH) {
    button2Pressed = false;
  }

  // Check button3 for 180-degree reverse rotation on stepper motor
  if (digitalRead(button3Pin) == LOW && !button3Pressed) {
    myServo.write(0);
    delay(3);
    rotateStepper(stepsPer180Deg / 2, false); // Reverse
    button3Pressed = true;
  }
  if (digitalRead(button3Pin) == HIGH) {
    button3Pressed = false;
  }

  // Check ledButtonPin to turn on the LED and rotate second servo to 180 degrees
  if (digitalRead(ledButtonPin) == LOW && !ledButtonPressed) {
    digitalWrite(ledPin, HIGH);  // Turn LED on
    digitalWrite(ledPin1, HIGH);
    digitalWrite(ledPin2, HIGH);  // Turn LED on
    digitalWrite(ledPin3, HIGH);
    digitalWrite(ledPin4, HIGH);
    secondServo.write(0);      // Rotate second servo to 180 degrees
    ledButtonPressed = true;
    Serial.println("LED turned on, rotating second servo to 180 degrees");
  }
  if (digitalRead(ledButtonPin) == HIGH) {
    ledButtonPressed = false;
  }

  // Check button4Pin to turn off the LED and reset second servo to 0 degrees
  if (digitalRead(button4Pin) == LOW && !button4Pressed) {
    digitalWrite(ledPin, LOW);   // Turn LED off
    digitalWrite(ledPin1, LOW);
    digitalWrite(ledPin2, LOW);
    digitalWrite(ledPin3, LOW);
    digitalWrite(ledPin4, LOW);
    myServo.write(0);
    secondServo.write(180);        // Rotate second servo back to 0 degrees
    button4Pressed = true;
    Serial.println("LED turned off, rotating second servo back to 0 degrees");
  }
  if (digitalRead(button4Pin) == HIGH) {
    button4Pressed = false;
  }  
}
}
// Function to rotate the stepper motor
void rotateStepper(int steps, bool forward) {
  for (int i = 0; i < steps; i++) {
    for (int pin = 0; pin < 4; pin++) {
      digitalWrite(stepperPins[pin], stepperSequence[currentStep][pin]);
    }
    if (forward) {
      currentStep = (currentStep + 1) % 8; // Increment for forward
    } else {
      currentStep = (currentStep - 1 + 8) % 8; // Decrement for reverse
    }
    delay(2); // Adjust for motor speed
  }
}
