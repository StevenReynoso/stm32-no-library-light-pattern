#include <stdint.h> 
#include "gpio.h"

void delay(void){
    for(volatile int i = 0; i < 1000000; i++);      // crappy delay, cycles depend on cpu frequency
}

int main(void){                                     

    gpio_config_t led_cfg = {                       // creates gpio config for PA5 to control ld2 light
        .pin = PIN('A', 5),                         // tell config which port and pin number to deal with
        .mode = GPIO_MODE_OUTPUT,                   // set mode to Output
        .otype = GPIO_OTYPE_PUSHPULL,               // set OTYPE to push-pull output 
        .speed = GPIO_SPEED_HIGH,                   // set Speed as high for output driver
        .pull = GPIO_NO_PULL                        // not using a pull up or pull down resistor
    };

    gpio_init_pin(led_cfg);                         // initializing pin with our config file

    while (1)
    {   
        GPIO('A')->ODR ^= (1 << 5);                 // Flip the PA5 output bit with ^
        delay();                                    // wait a bit - (Write better delay)
    }
    

}
