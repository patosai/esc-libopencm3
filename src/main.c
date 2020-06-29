#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

int main() {
  rcc_clock_setup_pll(&rcc_hse_16mhz_3v3[RCC_CLOCK_3V3_84MHZ]);
  rcc_periph_clock_enable(RCC_GPIOC);
  rcc_periph_clock_enable(RCC_GPIOE);
  gpio_mode_setup(GPIOC, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO8);
  gpio_mode_setup(GPIOE, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO0);

  gpio_set(GPIOE, GPIO0);

  int i;
  while (true) {
    gpio_toggle(GPIOC, GPIO8);
    for (i = 0; i < 1000000; i++) { /* Wait a bit. */
      __asm__("nop");
    }
  }
  return 0;
}
