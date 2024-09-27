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
b           _END                     // Finaliza el program