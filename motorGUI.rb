require 'tk'
require 'date'

# Crear la ventana principal
ventana = TkRoot.new { title "Control de Motor GUI con Tkinter" }
ventana.geometry = "450x300"

# Crear una etiqueta
etiqueta = TkLabel.new(ventana) do
  text "Estado del motor: Detenido"
  font "Arial 15"
  fg "blue"
  place(x: 0, y: 120)
end

# Crear una etiqueta para la fecha y hora
etiqueta2 = TkLabel.new(ventana) do
  font "Arial 15"
  fg "blue"
  place(x: 0, y: 170)
end

# Función para manejar el evento del botón
def izquierda(etiqueta, boton, boton2, boton3)
  puts "Botón izquierda presionado"  # Depuración
  etiqueta.text = "Estado del motor: Girando en sentido antihorario"
  boton.state = "disabled"
  boton2.state = "normal"
  boton3.state = "normal"
end

def derecha(etiqueta, boton, boton2, boton3)
  puts "Botón derecha presionado"  # Depuración
  etiqueta.text = "Estado del motor: Girando en sentido horario"
  boton.state = "normal"
  boton2.state = "normal"
  boton3.state = "disabled"
end

def detener(etiqueta, boton, boton2, boton3)
  puts "Botón detener presionado"  # Depuración
  etiqueta.text = "Estado del motor: Detenido"
  boton.state = "normal"
  boton2.state = "disabled"
  boton3.state = "normal"
end

def actualizar_fecha_hora(etiqueta2, ventana)
  fecha_hora_actual = DateTime.now.strftime("%H:%M:%S - %Y-%m-%d")
  etiqueta2.text = fecha_hora_actual
  ventana.after(1000) { actualizar_fecha_hora(etiqueta2, ventana) }  # Actualizar cada segundo
end

# Crear un botón
imagen = TkPhotoImage.new(file: "img/flecha-izquierda.png")
boton = TkButton.new(ventana) do
  image imagen
  place(x: 90, y: 15)
end

imagen2 = TkPhotoImage.new(file: "img/pausa.png")
boton2 = TkButton.new(ventana) do
  image imagen2
  state "disabled"
  place(x: 190, y: 15)
end

imagen3 = TkPhotoImage.new(file: "img/flecha-correcta.png")
boton3 = TkButton.new(ventana) do
  image imagen3
  place(x: 290, y: 15)
end

# Configurar comandos para los botones
boton.command = proc { izquierda(etiqueta, boton, boton2, boton3) }
boton2.command = proc { detener(etiqueta, boton, boton2, boton3) }
boton3.command = proc { derecha(etiqueta, boton, boton2, boton3) }

# Crear un botón para salir de la aplicación
root = TkRoot.new
quit_button = TkButton.new(root) do
  text "Salir"
  font "Arial 10"
  command { exit }
  place(x: 200, y: 230)
end

actualizar_fecha_hora(etiqueta2, ventana)
Tk.mainloop
