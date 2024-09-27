_Init:
mov         Rn1, 1               // ImgI - Guarda la direccion de memoria donde empieza la imagen en Rn1
mov         Rn2, 2               // ImgF - Guarda la direccion de memoria donde finaliza la imagen en Rn2
mov         Rn3, 3            // ImgSize - Guarda el tamaño de la imagen en Rn3
b           _BuildHistogram          // Salta al loop que recorre la imagen para construir el histograma 
mov         Rn4, 0                  // Primer registro del histograma en el que va a realizar la normalización
mov         Rn5, 64                 // Último registro del histograma en el que va a realizar la normalización
mov         Rn6, 255                // Intensidad máxima
b           _Normalize               // Salta al loop que va a normalizar el histograma
mov         Rn1, 4            // NewImgF - Guarda la direccion de memoria donde finaliza la imagen ecualizada en Rn1
b           _BuildImg                // Crea la imagen equalizada con los valores del histograma
b           _END                     // Finaliza el programa
_BuildHistogram:
load_8x8    Rn1, Rv1                // Sube 8 pixeles al registro vectorial Rv1
mods_8x8    Rv2, Rv1, 4             // Asigna la posición del registro del histograma a la que pertenece cada pixel en los dos primeros bits
inc_4x16   Rv2, 0                  // Incrementa al registro del histograma que se indica en el vector 0 del registro Rv2
inc_4x16   Rv2, 1                  // Incrementa al registro del histograma que se indica en el vector 1 del registro Rv2
inc_4x16   Rv2, 2                  // Incrementa al registro del histograma que se indica en el vector 2 del registro Rv2
inc_4x16   Rv2, 3                  // Incrementa al registro del histograma que se indica en el vector 3 del registro Rv2
inc_4x16   Rv2, 4                  // Incrementa al registro del histograma que se indica en el vector 4 del registro Rv2
inc_4x16   Rv2, 5                  // Incrementa al registro del histograma que se indica en el vector 5 del registro Rv2
inc_4x16   Rv2, 6                  // Incrementa al registro del histograma que se indica en el vector 6 del registro Rv2
inc_4x16   Rv2, 7                  // Incrementa al registro del histograma que se indica en el vector 7 del registro Rv2
add         Rn1, Rn1, 64            // Cambia la dirección para avanzar a los próximos 8 pixeles
cmp         Rn1, Rn2                // Verifica si ha llegado al dinal de la imagen
bnq         _BuildHistogram          // Si no ha llegado al final entonces vuelve al loop, si sí ha llegado al final entonces vuelve al flujo normal
_Normalize:
norm        Rn4, Rn4                // Realiza la división del primer registro vectorial del histograma entre la cantidad total de pixeles
inc         Rn4                     // Pasa a normalizar el siguiente registro del histograma
cmp         Rn4, Rn5                // Verifica si ha recorrido todo el histograma
bnq         _Normalize               // Si aún no los ha normalizado todos sigue en el loop, si sí entonces vuelve al flujo normal
_BuildImg:
load_8x8    Rn1, Rv1                // Sube 8 pixeles de la imagen original al registro vectorial Rv1
mods_8x8    Rv2, Rv1, 4             // Asigna la posición del registro del histograma a la que pertenece cada pixel en los dos primeros bits
get_8x8     Rv2, Rv2                // Toma los nuevos valores de instensidades del histograma
store_8x8   Rn2, Rv2                // Almacena los nuevos valores de los pixeles en memoria justo después de la imagen original
add         Rn2, Rn2, 64            // Avanza 8 pixeles 
cmp         Rn1, Rn2                // Verifica si ya construyó la imagen por completo
bnq         _BuildImg                // Si no ha terminado continúa en el loop, si sí vuelve al flujo normal
_END:    
end