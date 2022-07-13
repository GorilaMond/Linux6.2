mov ax, 0b800h; 0b800h就是在文本模式下所 显存起始地址
mov ds, ax

mov byte [0x00],'2'
mov byte [0x02],'0'
mov byte [0x04],'2'
mov byte [0x06],'2'
mov byte [0x08],','
mov byte [0x0a],'h'
mov byte [0x0c],'a'
mov byte [0x0e],'p'
mov byte [0x10],'p'
mov byte [0x12],'y'
mov byte [0x14],' '
mov byte [0x16],'n'
mov byte [0x18],'e'
mov byte [0x1a],'w'
mov byte [0x1c],' '
mov byte [0x1e],'y'
mov byte [0x20],'e'
mov byte [0x22],'a'
mov byte [0x24],'r'
mov byte [0x26],'!'

jmp $

times 510-($-$$) db 0
db 0x55,0xaa