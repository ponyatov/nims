# обработчик критической ошибки (kernel panic)
proc panic(s: string) = discard
# вывод строки на системную консоль (printk)
proc rawoutput(s: string) = discard
