-- Punto y Compra (aplicado el 2026-11-10): costo del producto el día de la venta
alter table public.carrito_items add column if not exists costo_unitario numeric;
-- Ventas existentes: se llenaron una sola vez con el costo del catálogo de ese momento
update public.carrito_items ci set costo_unitario = coalesce(p.costo,0) from public.prendas p where p.id = ci.prenda_id and ci.costo_unitario is null;
