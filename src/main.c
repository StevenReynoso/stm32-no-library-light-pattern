

/* === Manual LED Control (Hardcoded Pin Setup) ===
 * This version is optimized for minimal Flash usage and avoids RAM allocation.
 * While not scalable, it is ideal for small-scale testing (e.g., 5 LEDs).
 * No dynamic pin arrays or loop abstraction are used.
 */

#include <stdint.h> 
#include "gpio.h"

void delay(void){
    for(volatile int i = 0; i < 100000; i++);      // crappy delay, cycles depend on cpu frequency
}

int main(void){                                     
    //red
    gpio_config_t led_cfg0 = {                      // creates gpio config for PA5 to control LED
        .pin = PIN('A', 5),                         // tell config which port and pin number to deal with
        .mode = GPIO_MODE_OUTPUT,                   // set mode to Output
        .otype = GPIO_OTYPE_PUSHPULL,               // set OTYPE to push-pull output 
        .speed = GPIO_SPEED_HIGH,                   // set Speed as high for output driver
        .pull = GPIO_NO_PULL                        // not using a pull up or pull down resistor
    };
    // Blue
    gpio_config_t led_cfg1 = {                      // creates gpio config for PA6 to control LED
        .pin = PIN('A', 6),                         // tell config which port and pin number to deal with
        .mode = GPIO_MODE_OUTPUT,                   // set mode to Output
        .otype = GPIO_OTYPE_PUSHPULL,               // set OTYPE to push-pull output 
        .speed = GPIO_SPEED_HIGH,                   // set Speed as high for output driver
        .pull = GPIO_NO_PULL                        // not using a pull up or pull down resistor
    };
    // Yellow
    gpio_config_t led_cfg2 = {                      // creates gpio config for PA7 to control LED
        .pin = PIN('A', 7),                         // tell config which port and pin number to deal with
        .mode = GPIO_MODE_OUTPUT,                   // set mode to Output
        .otype = GPIO_OTYPE_PUSHPULL,               // set OTYPE to push-pull output 
        .speed = GPIO_SPEED_MEDIUM,                 // set Speed as high for output driver
        .pull = GPIO_NO_PULL                        // not using a pull up or pull down resistor
    };
    // Green
    gpio_config_t led_cfg3 = {                      // creates gpio config for PB6 to control LED
        .pin = PIN('B', 6),                         // tell config which port and pin number to deal with
        .mode = GPIO_MODE_OUTPUT,                   // set mode to Output
        .otype = GPIO_OTYPE_PUSHPULL,               // set OTYPE to push-pull output 
        .speed = GPIO_SPEED_FAST,                   // set Speed as high for output driver
        .pull = GPIO_NO_PULL                        // not using a pull up or pull down resistor
    };
    // White
    gpio_config_t led_cfg4 = {                      // creates gpio config for PC7 to control LED
        .pin = PIN('C', 7),                         // tell config which port and pin number to deal with
        .mode = GPIO_MODE_OUTPUT,                   // set mode to Output
        .otype = GPIO_OTYPE_PUSHPULL,               // set OTYPE to push-pull output 
        .speed = GPIO_SPEED_HIGH,                   // set Speed as high for output driver
        .pull = GPIO_NO_PULL                        // not using a pull up or pull down resistor
    };



    gpio_init_pin(led_cfg0);                         // initializing pin with our config file
    gpio_init_pin(led_cfg1);
    gpio_init_pin(led_cfg2);
    gpio_init_pin(led_cfg3);
    gpio_init_pin(led_cfg4);

    while (1)
    {   
        GPIO('A')->ODR ^= (1 << 5);                 // Flip the PA5 output bit with ^
        delay();                                    // wait a bit - (Write better delay)
        GPIO('A')->ODR ^= (1 << 6);                 // Flip the PA6 output bit with ^
        delay();  
        GPIO('A')->ODR ^= (1 << 7);                 // Flip the PA7 output bit with ^
        delay();  
        GPIO('B')->ODR ^= (1 << 6);                 // Flip the PB6 output bit with ^
        delay();  
        GPIO('C')->ODR ^= (1 << 7);                 // Flip the PC7 output bit with ^  
        delay();  
    }
    

}
