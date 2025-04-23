
#include "gpio.h"

/* === gpio_set_mode ===
 * Sets the mode of a GPIO pin (input, output, alternate function, analog).
 * - Extracts GPIO bank and pin number from encoded `pin`.
 * - Updates only the relevant bits in MODER.
 */
inline void gpio_set_mode(uint16_t pin, uint8_t mode) {
    struct gpio *gpio = GPIO(PINBANK(pin));                   // Get pointer to GPIO port struct
    uint8_t gpio_pin = PINNO(pin);                            // Extract pin number (0–15)

    gpio->MODER &= ~(0x3U << (gpio_pin * 2));                 // Clear the 2 bits for this pin
    gpio->MODER |= ((mode & 0x3U) << (gpio_pin * 2));         // Set new mode
}


/* === rcc_gpio_enr ===
 * Enables the clock for the specified GPIO bank via RCC_AHB1ENR.
 * - `bank_num` is 0 for A, 1 for B, etc.
 */
void rcc_gpio_enr(uint8_t bank_num) {
    RCC_AHB1ENR |= (1 << bank_num);                           // Enable clock for corresponding GPIO port
}


/* === gpio_init_pin ===
 * Configures a GPIO pin based on the given configuration struct:
 * - Enables peripheral clock
 * - Sets mode, output type, speed, and pull-up/down configuration
 */
void gpio_init_pin(gpio_config_t cfg) {
    struct gpio *gpio = GPIO(PINBANK(cfg.pin) + 'A');              // Get GPIO port base address
    uint8_t gpio_pin = PINNO(cfg.pin);                       // Extract pin number (0–15)

    rcc_gpio_enr(PINBANK(cfg.pin));                          // Enable clock for this GPIO bank

    /* Set pin mode (MODER) */
    gpio->MODER &= ~(0x03 << (gpio_pin * 2));                // Clear mode bits
    gpio->MODER |= ((cfg.mode & 0x03) << (gpio_pin * 2));    // Set mode bits

    /* Set output type (OTYPER) */
    gpio->OTYPER &= ~(1 << gpio_pin);                        // Clear output type
    gpio->OTYPER |=  ((cfg.otype & 0x01) << gpio_pin);       // Set output type

    /* Set output speed (OSPEEDR) */
    gpio->OSPEEDR &= ~(0x03 << (gpio_pin * 2));              // Clear speed bits
    gpio->OSPEEDR |= ((cfg.speed & 0x03) << (gpio_pin * 2)); // Set speed bits

    /* Set pull-up/pull-down (PUPDR) */
    gpio->PUPDR &= ~(0x03 << (gpio_pin * 2));                // Clear pull config
    gpio->PUPDR |= ((cfg.pull & 0x03) << (gpio_pin * 2));    // Set pull config
}
