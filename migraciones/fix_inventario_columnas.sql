-- Punto y Compra · Paso 1 Fase 4 (aplicado el 2026-11-06). Columnas que el módulo Inventario usa
-- y que faltaban en schema_base.sql de la plantilla.
alter table public.inventario_sesiones add column if not exists estado text default 'en_progreso';
alter table public.inventario_sesiones add column if not exists fecha_fin timestamp with time zone;
alter table public.inventario_detalle add column if not exists stock_id uuid;
