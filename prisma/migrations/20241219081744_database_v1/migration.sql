-- CreateTable
CREATE TABLE "administrador" (
    "ID_Administrador" SERIAL NOT NULL,
    "nombre" VARCHAR(25) NOT NULL,
    "Apellido_Paterno" VARCHAR(25) NOT NULL,
    "Apellido_Materno" VARCHAR(25),
    "correo" VARCHAR(50) NOT NULL,
    "contraseña" VARCHAR(64) NOT NULL,
    "ID_Rol" INTEGER NOT NULL,
    "Fecha_Creacion" DATE NOT NULL,

    CONSTRAINT "administrador_pkey" PRIMARY KEY ("ID_Administrador")
);

-- CreateTable
CREATE TABLE "analisis_clinico" (
    "ID_Analisis_Clinico" SERIAL NOT NULL,
    "ID_Muestra" INTEGER NOT NULL,
    "ID_Resultado_Analisis" INTEGER,
    "ID_Personal" INTEGER NOT NULL,
    "ID_Tipo_Analisis_Clinico" INTEGER NOT NULL,

    CONSTRAINT "analisis_clinico_pkey" PRIMARY KEY ("ID_Analisis_Clinico")
);

-- CreateTable
CREATE TABLE "boleta" (
    "ID_Boleta" SERIAL NOT NULL,
    "ID_Comprobante" INTEGER NOT NULL,
    "detalles" TEXT,

    CONSTRAINT "boleta_pkey" PRIMARY KEY ("ID_Boleta")
);

-- CreateTable
CREATE TABLE "clase_analisis_clinico" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(255) NOT NULL,

    CONSTRAINT "clase_analisis_clinico_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clase_proveedor" (
    "ID_Proveedor" SERIAL NOT NULL,
    "Nombre_Proveedor" VARCHAR(25) NOT NULL,
    "ID_Tipo_Suministro" INTEGER NOT NULL,
    "contacto" VARCHAR(25),

    CONSTRAINT "clase_proveedor_pkey" PRIMARY KEY ("ID_Proveedor")
);

-- CreateTable
CREATE TABLE "comprobante_pago" (
    "ID_Comprobante" SERIAL NOT NULL,
    "ID_Analisis_Clinico" INTEGER NOT NULL,
    "Fecha_Pago" DATE NOT NULL,
    "ID_Estado_Pago" INTEGER NOT NULL,
    "ID_Tipo_Pago" INTEGER NOT NULL,
    "DNI_Paciente" CHAR(8) NOT NULL,

    CONSTRAINT "comprobante_pago_pkey" PRIMARY KEY ("ID_Comprobante")
);

-- CreateTable
CREATE TABLE "detalles_orden_compra" (
    "ID_Detalle" SERIAL NOT NULL,
    "ID_Orden_Compra" INTEGER NOT NULL,
    "ID_Tipo_Producto" INTEGER NOT NULL,
    "ID_Producto" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL,

    CONSTRAINT "detalles_orden_compra_pkey" PRIMARY KEY ("ID_Detalle")
);

-- CreateTable
CREATE TABLE "equipo" (
    "ID_Equipo" SERIAL NOT NULL,
    "ID_Marca" INTEGER NOT NULL,
    "ID_Modelo" INTEGER NOT NULL,
    "ID_Tipo_Equipo" INTEGER NOT NULL,
    "Num_Serie_Equipo" VARCHAR(50),
    "Fecha_Compra" DATE,
    "Fecha_Mantenimiento" DATE,
    "ID_Estado_Equipo" INTEGER,

    CONSTRAINT "equipo_pkey" PRIMARY KEY ("ID_Equipo")
);

-- CreateTable
CREATE TABLE "estado_equipo" (
    "ID_Estado_Equipo" SERIAL NOT NULL,
    "descripcion" VARCHAR(50) NOT NULL,

    CONSTRAINT "estado_equipo_pkey" PRIMARY KEY ("ID_Estado_Equipo")
);

-- CreateTable
CREATE TABLE "estado_material" (
    "ID_Estado_Material" SERIAL NOT NULL,
    "nombre" VARCHAR(25) NOT NULL,

    CONSTRAINT "estado_material_pkey" PRIMARY KEY ("ID_Estado_Material")
);

-- CreateTable
CREATE TABLE "estado_muestra" (
    "ID_Estado_Muestra" SERIAL NOT NULL,
    "nombre" VARCHAR(25) NOT NULL,

    CONSTRAINT "estado_muestra_pkey" PRIMARY KEY ("ID_Estado_Muestra")
);

-- CreateTable
CREATE TABLE "estado_pago" (
    "ID_Estado_Pago" SERIAL NOT NULL,
    "nombre" VARCHAR(25) NOT NULL,

    CONSTRAINT "estado_pago_pkey" PRIMARY KEY ("ID_Estado_Pago")
);

-- CreateTable
CREATE TABLE "factura" (
    "ID_Factura" SERIAL NOT NULL,
    "ID_Comprobante" INTEGER NOT NULL,
    "Razon_Social" VARCHAR(25) NOT NULL,
    "RUC" CHAR(11) NOT NULL,

    CONSTRAINT "factura_pkey" PRIMARY KEY ("ID_Factura")
);

-- CreateTable
CREATE TABLE "marca" (
    "ID_Marca" SERIAL NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,

    CONSTRAINT "marca_pkey" PRIMARY KEY ("ID_Marca")
);

-- CreateTable
CREATE TABLE "material_desechable" (
    "ID_Material_Desechable" SERIAL NOT NULL,
    "Cantidad_Stock" INTEGER NOT NULL,
    "Fecha_Expiracion" DATE,

    CONSTRAINT "material_desechable_pkey" PRIMARY KEY ("ID_Material_Desechable")
);

-- CreateTable
CREATE TABLE "material_quirurgico" (
    "ID_Material_Quirurgico" SERIAL NOT NULL,
    "Num_Serie_Material" VARCHAR(10) NOT NULL,
    "ID_Marca" INTEGER NOT NULL,
    "Fecha_Compra" DATE NOT NULL,
    "ID_Estado_Material" INTEGER NOT NULL,
    "Unidad_Medida" INTEGER NOT NULL,
    "Nombre_Material" VARCHAR(25) NOT NULL,
    "descripcion" TEXT NOT NULL,
    "Tipo_de_Material" INTEGER NOT NULL,
    "ID_MaterialDesReu" INTEGER NOT NULL,

    CONSTRAINT "material_quirurgico_pkey" PRIMARY KEY ("ID_Material_Quirurgico")
);

-- CreateTable
CREATE TABLE "material_reutilizable" (
    "ID_Material_Reutilizable" SERIAL NOT NULL,
    "Cantidad_Disponible" INTEGER NOT NULL,
    "Frecuencia_Mantenimiento" INTEGER,

    CONSTRAINT "material_reutilizable_pkey" PRIMARY KEY ("ID_Material_Reutilizable")
);

-- CreateTable
CREATE TABLE "modelo" (
    "ID_Modelo" SERIAL NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,

    CONSTRAINT "modelo_pkey" PRIMARY KEY ("ID_Modelo")
);

-- CreateTable
CREATE TABLE "muestra" (
    "ID_Muestra" SERIAL NOT NULL,
    "DNI_Paciente" CHAR(8) NOT NULL,
    "Fecha_Recepcion" DATE NOT NULL,
    "ID_Estado_Muestra" INTEGER NOT NULL,
    "ID_Tipo_Muestra" INTEGER NOT NULL,

    CONSTRAINT "muestra_pkey" PRIMARY KEY ("ID_Muestra")
);

-- CreateTable
CREATE TABLE "orden_compra" (
    "ID_Orden_Compra" SERIAL NOT NULL,
    "ID_Proveedor" INTEGER NOT NULL,
    "Fecha_Orden" DATE NOT NULL,
    "Lista_Productos" TEXT,

    CONSTRAINT "orden_compra_pkey" PRIMARY KEY ("ID_Orden_Compra")
);

-- CreateTable
CREATE TABLE "paciente" (
    "DNI_Paciente" CHAR(8) NOT NULL,
    "nombre" VARCHAR(25) NOT NULL,
    "Apellido_Paterno" VARCHAR(25) NOT NULL,
    "Apellido_Materno" VARCHAR(25),
    "Numero_Telefono" VARCHAR(15),
    "edad" INTEGER,
    "direccion" VARCHAR(100),

    CONSTRAINT "paciente_pkey" PRIMARY KEY ("DNI_Paciente")
);

-- CreateTable
CREATE TABLE "personal_laboratorio" (
    "ID_Personal" SERIAL NOT NULL,
    "nombre" VARCHAR(25) NOT NULL,
    "apellido" VARCHAR(25) NOT NULL,
    "Apellido_Materno" VARCHAR(50),
    "DNI_Personal" CHAR(8) NOT NULL,
    "especializacion" VARCHAR(50),
    "Fecha_Contratacion" DATE NOT NULL,
    "ID_Administrador" INTEGER NOT NULL,

    CONSTRAINT "personal_laboratorio_pkey" PRIMARY KEY ("ID_Personal")
);

-- CreateTable
CREATE TABLE "reagente" (
    "ID_Reagente" SERIAL NOT NULL,
    "Nombre_Reagente" VARCHAR(50) NOT NULL,
    "stock" INTEGER NOT NULL,
    "Fecha_Caducidad" DATE,

    CONSTRAINT "reagente_pkey" PRIMARY KEY ("ID_Reagente")
);

-- CreateTable
CREATE TABLE "registro_mantenimiento" (
    "ID_Mantenimiento" SERIAL NOT NULL,
    "ID_Equipo" INTEGER NOT NULL,
    "Fecha_Mantenimiento" DATE NOT NULL,
    "Parametros_Verificados" TEXT,
    "Resultado_Verificacion" TEXT,

    CONSTRAINT "registro_mantenimiento_pkey" PRIMARY KEY ("ID_Mantenimiento")
);

-- CreateTable
CREATE TABLE "resultados" (
    "ID_Resultado_Analisis" SERIAL NOT NULL,
    "resultados" TEXT,
    "reporte" VARCHAR(255),
    "Fecha_Entrega" DATE,

    CONSTRAINT "resultados_pkey" PRIMARY KEY ("ID_Resultado_Analisis")
);

-- CreateTable
CREATE TABLE "rol" (
    "ID_Rol" SERIAL NOT NULL,
    "nombre" VARCHAR(25) NOT NULL,

    CONSTRAINT "rol_pkey" PRIMARY KEY ("ID_Rol")
);

-- CreateTable
CREATE TABLE "tipo_analisis_clinico" (
    "ID_Tipo_Analisis_Clinico" SERIAL NOT NULL,
    "Nombre_Analisis" VARCHAR(50) NOT NULL,
    "precio" DECIMAL(10,2) NOT NULL,
    "Valor_Referencia" TEXT,
    "ID_clase_analisis_clinico" INTEGER,
    "ID_Material_Quirurgico" INTEGER,
    "ID_Equipo" INTEGER,
    "ID_Reagente" INTEGER,

    CONSTRAINT "tipo_analisis_clinico_pkey" PRIMARY KEY ("ID_Tipo_Analisis_Clinico")
);

-- CreateTable
CREATE TABLE "tipo_equipo" (
    "ID_Tipo_Equipo" SERIAL NOT NULL,
    "Descripcion_Tipo_Equipo" VARCHAR(50),

    CONSTRAINT "tipo_equipo_pkey" PRIMARY KEY ("ID_Tipo_Equipo")
);

-- CreateTable
CREATE TABLE "tipo_muestra" (
    "ID_Tipo_Muestra" SERIAL NOT NULL,
    "nombre" VARCHAR(25) NOT NULL,

    CONSTRAINT "tipo_muestra_pkey" PRIMARY KEY ("ID_Tipo_Muestra")
);

-- CreateTable
CREATE TABLE "tipo_pago" (
    "ID_Tipo_Pago" SERIAL NOT NULL,
    "Metodo_Pago" VARCHAR(25) NOT NULL,

    CONSTRAINT "tipo_pago_pkey" PRIMARY KEY ("ID_Tipo_Pago")
);

-- CreateTable
CREATE TABLE "tipo_suministro" (
    "ID_Tipo_Suministro" SERIAL NOT NULL,

    CONSTRAINT "tipo_suministro_pkey" PRIMARY KEY ("ID_Tipo_Suministro")
);

-- CreateIndex
CREATE UNIQUE INDEX "administrador_correo_key" ON "administrador"("correo");

-- CreateIndex
CREATE UNIQUE INDEX "personal_laboratorio_DNI_Personal_key" ON "personal_laboratorio"("DNI_Personal");

-- AddForeignKey
ALTER TABLE "administrador" ADD CONSTRAINT "administrador_ID_Rol_fkey" FOREIGN KEY ("ID_Rol") REFERENCES "rol"("ID_Rol") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "analisis_clinico" ADD CONSTRAINT "analisis_clinico_ID_Muestra_fkey" FOREIGN KEY ("ID_Muestra") REFERENCES "muestra"("ID_Muestra") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "analisis_clinico" ADD CONSTRAINT "analisis_clinico_ID_Resultado_Analisis_fkey" FOREIGN KEY ("ID_Resultado_Analisis") REFERENCES "resultados"("ID_Resultado_Analisis") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "analisis_clinico" ADD CONSTRAINT "analisis_clinico_ID_Personal_fkey" FOREIGN KEY ("ID_Personal") REFERENCES "personal_laboratorio"("ID_Personal") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "analisis_clinico" ADD CONSTRAINT "analisis_clinico_ID_Tipo_Analisis_Clinico_fkey" FOREIGN KEY ("ID_Tipo_Analisis_Clinico") REFERENCES "tipo_analisis_clinico"("ID_Tipo_Analisis_Clinico") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "boleta" ADD CONSTRAINT "boleta_ID_Comprobante_fkey" FOREIGN KEY ("ID_Comprobante") REFERENCES "comprobante_pago"("ID_Comprobante") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "clase_proveedor" ADD CONSTRAINT "clase_proveedor_ID_Tipo_Suministro_fkey" FOREIGN KEY ("ID_Tipo_Suministro") REFERENCES "tipo_suministro"("ID_Tipo_Suministro") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comprobante_pago" ADD CONSTRAINT "comprobante_pago_ID_Analisis_Clinico_fkey" FOREIGN KEY ("ID_Analisis_Clinico") REFERENCES "analisis_clinico"("ID_Analisis_Clinico") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comprobante_pago" ADD CONSTRAINT "comprobante_pago_ID_Estado_Pago_fkey" FOREIGN KEY ("ID_Estado_Pago") REFERENCES "estado_pago"("ID_Estado_Pago") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comprobante_pago" ADD CONSTRAINT "comprobante_pago_ID_Tipo_Pago_fkey" FOREIGN KEY ("ID_Tipo_Pago") REFERENCES "tipo_pago"("ID_Tipo_Pago") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comprobante_pago" ADD CONSTRAINT "comprobante_pago_DNI_Paciente_fkey" FOREIGN KEY ("DNI_Paciente") REFERENCES "paciente"("DNI_Paciente") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "detalles_orden_compra" ADD CONSTRAINT "detalles_orden_compra_ID_Orden_Compra_fkey" FOREIGN KEY ("ID_Orden_Compra") REFERENCES "orden_compra"("ID_Orden_Compra") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipo" ADD CONSTRAINT "equipo_ID_Marca_fkey" FOREIGN KEY ("ID_Marca") REFERENCES "marca"("ID_Marca") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipo" ADD CONSTRAINT "equipo_ID_Modelo_fkey" FOREIGN KEY ("ID_Modelo") REFERENCES "modelo"("ID_Modelo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipo" ADD CONSTRAINT "equipo_ID_Tipo_Equipo_fkey" FOREIGN KEY ("ID_Tipo_Equipo") REFERENCES "tipo_equipo"("ID_Tipo_Equipo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipo" ADD CONSTRAINT "equipo_ID_Estado_Equipo_fkey" FOREIGN KEY ("ID_Estado_Equipo") REFERENCES "estado_equipo"("ID_Estado_Equipo") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "factura" ADD CONSTRAINT "factura_ID_Comprobante_fkey" FOREIGN KEY ("ID_Comprobante") REFERENCES "comprobante_pago"("ID_Comprobante") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "material_quirurgico" ADD CONSTRAINT "material_quirurgico_ID_Estado_Material_fkey" FOREIGN KEY ("ID_Estado_Material") REFERENCES "estado_material"("ID_Estado_Material") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "muestra" ADD CONSTRAINT "muestra_DNI_Paciente_fkey" FOREIGN KEY ("DNI_Paciente") REFERENCES "paciente"("DNI_Paciente") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "muestra" ADD CONSTRAINT "muestra_ID_Estado_Muestra_fkey" FOREIGN KEY ("ID_Estado_Muestra") REFERENCES "estado_muestra"("ID_Estado_Muestra") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "muestra" ADD CONSTRAINT "muestra_ID_Tipo_Muestra_fkey" FOREIGN KEY ("ID_Tipo_Muestra") REFERENCES "tipo_muestra"("ID_Tipo_Muestra") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orden_compra" ADD CONSTRAINT "orden_compra_ID_Proveedor_fkey" FOREIGN KEY ("ID_Proveedor") REFERENCES "clase_proveedor"("ID_Proveedor") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "personal_laboratorio" ADD CONSTRAINT "personal_laboratorio_ID_Administrador_fkey" FOREIGN KEY ("ID_Administrador") REFERENCES "administrador"("ID_Administrador") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "registro_mantenimiento" ADD CONSTRAINT "registro_mantenimiento_ID_Equipo_fkey" FOREIGN KEY ("ID_Equipo") REFERENCES "equipo"("ID_Equipo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tipo_analisis_clinico" ADD CONSTRAINT "tipo_analisis_clinico_ID_clase_analisis_clinico_fkey" FOREIGN KEY ("ID_clase_analisis_clinico") REFERENCES "clase_analisis_clinico"("id") ON DELETE SET NULL ON UPDATE CASCADE;
