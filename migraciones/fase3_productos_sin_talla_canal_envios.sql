-- Punto y Compra · Fase 3 (aplicado el 2026-11-06 en el proyecto puntoycompra)
alter table public.prendas add column if not exists especificaciones text;
alter table public.carrito_items add column if not exists especificacion text;
alter table public.carrito_items alter column talla set default 'Única';
alter table public.pedidos add column if not exists canal text;
alter table public.pedidos add column if not exists fecha_programada date;
alter table public.pedidos alter column costo_envio set default 0;
alter table public.clientes alter column costo_envio set default 0;
alter table public.pagos drop constraint if exists pagos_metodo_check;
alter table public.pagos add constraint pagos_metodo_check CHECK (metodo = ANY (ARRAY['Yape','Plin','Transferencia','Tarjeta de crédito']));
