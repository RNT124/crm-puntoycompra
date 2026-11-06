-- ════════════════════════════════════════════════════════════════════
-- schema_base.sql — Esquema completo del CRM (SIN datos de ninguna clienta)
-- Cómo usarlo: Supabase → SQL Editor → pegar TODO → Run.
-- Antes de correrlo: cambia 'PED' (más abajo) por 3 letras de tu marca.
-- ════════════════════════════════════════════════════════════════════

-- ── 1. TABLAS ──────────────────────────────────────────────────────
create table if not exists public.asistencia (
  id uuid default gen_random_uuid() not null,
  usuario text not null,
  fecha date not null,
  hora_entrada timestamp with time zone,
  hora_salida_almuerzo timestamp with time zone,
  hora_regreso_almuerzo timestamp with time zone,
  hora_salida timestamp with time zone,
  created_at timestamp with time zone default now()
);
create table if not exists public.brasil_compras (
  id uuid default gen_random_uuid() not null,
  fecha date default CURRENT_DATE not null,
  producto text not null,
  variante text,
  cantidad integer not null,
  costo_rl numeric default 0 not null,
  creado_en timestamp with time zone default now() not null
);
create table if not exists public.brasil_gastos (
  id uuid default gen_random_uuid() not null,
  fecha date default CURRENT_DATE not null,
  tipo text not null,
  monto numeric default 0 not null,
  moneda text default 'R$'::text not null,
  nota text,
  creado_en timestamp with time zone default now() not null
);
create table if not exists public.brasil_items (
  id uuid default gen_random_uuid() not null,
  pedido_id uuid not null,
  producto text not null,
  variante text,
  cantidad integer default 1 not null,
  precio_venta numeric default 0 not null,
  comprado boolean default false not null,
  costo_rl numeric,
  creado_en timestamp with time zone default now() not null,
  canal text,
  en_mano boolean
);
create table if not exists public.brasil_pedidos (
  id uuid default gen_random_uuid() not null,
  cliente_id uuid,
  estado text default 'por_comprar'::text not null,
  pagado boolean default false not null,
  courier_codigo text,
  creado_en timestamp with time zone default now() not null,
  despachado_en timestamp with time zone,
  usuario_wa text,
  empacado_en timestamp with time zone,
  datos_en timestamp with time zone,
  etiqueta_en timestamp with time zone,
  shalom_orden text,
  shalom_clave text,
  shalom_emision timestamp with time zone,
  shalom_foto text
);
create table if not exists public.brasil_productos (
  id uuid default gen_random_uuid() not null,
  nombre text not null,
  precio_venta numeric,
  variantes jsonb default '[]'::jsonb not null,
  creado_en timestamp with time zone default now() not null,
  costo_rl numeric
);
create table if not exists public.carrito_items (
  id uuid default gen_random_uuid() not null,
  carrito_id uuid,
  prenda_id uuid,
  talla text not null,
  precio_unitario numeric not null,
  agregado_en timestamp with time zone default now(),
  color text,
  estado_bolsa text default 'sin_agregar'::text,
  estado_pago text default 'pendiente'::text,
  monto_pagado numeric default 0,
  preventa boolean default false not null,
  preventa_fecha_estimada date
);
create table if not exists public.carritos (
  id uuid default gen_random_uuid() not null,
  cliente_id uuid,
  estado text default 'abierto'::text,
  total numeric default 0,
  creado_en timestamp with time zone default now(),
  actualizado_en timestamp with time zone default now()
);
create table if not exists public.clientes (
  id uuid default gen_random_uuid() not null,
  telefono text not null,
  nombre text,
  talla text,
  distrito text,
  direccion text,
  referencia text,
  costo_envio integer default 13,
  total_gastado numeric default 0,
  pedidos_count integer default 0,
  creado_en timestamp with time zone default now(),
  actualizado_en timestamp with time zone default now(),
  dni text,
  tipo_envio_preferido text,
  envio_urgente_en timestamp with time zone,
  shalom_agencia text
);
create table if not exists public.clientes_historial (
  id uuid default gen_random_uuid() not null,
  cliente_id uuid,
  tipo_evento text not null,
  nombre text,
  tipo_envio text,
  distrito text,
  direccion text,
  referencia text,
  dni text,
  creado_en timestamp with time zone default now() not null
);
create table if not exists public.compras (
  id uuid default gen_random_uuid() not null,
  prenda_id uuid,
  talla text,
  color text,
  cantidad integer not null,
  costo_total numeric not null,
  proveedor text,
  fecha date default CURRENT_DATE not null,
  creado_en timestamp with time zone default now() not null
);
create table if not exists public.gastos (
  id uuid default gen_random_uuid() not null,
  categoria text not null,
  monto numeric not null,
  descripcion text,
  fecha date default CURRENT_DATE not null,
  creado_en timestamp with time zone default now() not null
);
create table if not exists public.inventario_detalle (
  id uuid default gen_random_uuid() not null,
  sesion_id uuid,
  prenda_id uuid,
  prenda_nombre text,
  talla text,
  color text,
  stock_sistema integer,
  stock_contado integer,
  diferencia integer
);
create table if not exists public.inventario_sesiones (
  id uuid default gen_random_uuid() not null,
  tipo text not null,
  usuario text not null,
  fecha timestamp with time zone default now(),
  total_contadas integer default 0,
  total_diferencias integer default 0,
  diferencia_neta integer default 0
);
create table if not exists public.lives (
  id uuid default gen_random_uuid() not null,
  fecha date default CURRENT_DATE not null,
  duracion_min integer,
  total_vendido numeric default 0,
  num_pedidos integer default 0,
  notas text,
  creado_en timestamp with time zone default now()
);
create table if not exists public.pagos (
  id uuid default gen_random_uuid() not null,
  pedido_id uuid,
  metodo text,
  monto numeric not null,
  estado text default 'confirmado'::text,
  captura_url text,
  confirmado_por text,
  pagado_en timestamp with time zone default now()
);
create table if not exists public.pedidos (
  id uuid default gen_random_uuid() not null,
  numero text not null,
  cliente_id uuid,
  carrito_id uuid,
  estado text default 'pago_pendiente'::text,
  subtotal numeric not null,
  costo_envio numeric default 13,
  total numeric not null,
  monto_pagado numeric default 0,
  tipo_envio text,
  distrito text,
  direccion text,
  courier_codigo text,
  creado_en timestamp with time zone default now(),
  actualizado_en timestamp with time zone default now(),
  envio_pagado boolean default false not null,
  notas text,
  etiqueta_en timestamp with time zone,
  shalom_orden text,
  shalom_clave text,
  shalom_emision timestamp with time zone,
  shalom_foto text
);
create table if not exists public.pedidos_historial (
  id uuid default gen_random_uuid() not null,
  pedido_id uuid,
  estado_anterior text,
  estado_nuevo text not null,
  usuario text,
  nota text,
  creado_en timestamp with time zone default now() not null
);
create table if not exists public.prenda_stock (
  id uuid default gen_random_uuid() not null,
  prenda_id uuid,
  talla text not null,
  color text not null,
  cantidad integer default 0,
  creado_en timestamp with time zone default now()
);
create table if not exists public.prenda_variantes (
  id uuid default gen_random_uuid() not null,
  prenda_id uuid,
  talla text not null,
  color text default ''::text not null,
  stock integer default 0 not null,
  actualizado_en timestamp with time zone default now()
);
create table if not exists public.prendas (
  id uuid default gen_random_uuid() not null,
  nombre text not null,
  codigo text,
  precio numeric not null,
  costo numeric default 0,
  categoria text,
  tallas text[] default '{}'::text[],
  foto_url text,
  activo boolean default true,
  creado_en timestamp with time zone default now(),
  colores text,
  stock integer default 0 not null
);
create table if not exists public.shalom_agencias (
  nombre text not null,
  departamento text,
  provincia text,
  distrito text,
  direccion text,
  destino boolean default true,
  actualizado_en timestamp with time zone default now()
);
create table if not exists public.shalom_pro_destinos (
  agencia text not null,
  destino text not null,
  actualizado_en timestamp with time zone default now()
);
create table if not exists public.usuarios (
  id uuid default gen_random_uuid() not null,
  username text not null,
  password_hash text not null,
  nombre text not null,
  rol text not null,
  activo boolean default true,
  creado_en timestamp with time zone default now()
);

-- ── 2. LLAVES PRIMARIAS, ÚNICOS Y CHEQUEOS ─────────────────────────
alter table public.asistencia add constraint asistencia_pkey PRIMARY KEY (id);
alter table public.asistencia add constraint asistencia_usuario_fecha_key UNIQUE (usuario, fecha);
alter table public.brasil_compras add constraint brasil_compras_pkey PRIMARY KEY (id);
alter table public.brasil_gastos add constraint brasil_gastos_pkey PRIMARY KEY (id);
alter table public.brasil_items add constraint brasil_items_pkey PRIMARY KEY (id);
alter table public.brasil_pedidos add constraint brasil_pedidos_pkey PRIMARY KEY (id);
alter table public.brasil_productos add constraint brasil_productos_pkey PRIMARY KEY (id);
alter table public.carrito_items add constraint carrito_items_pkey PRIMARY KEY (id);
alter table public.carritos add constraint carritos_estado_check CHECK ((estado = ANY (ARRAY['abierto'::text, 'en_pedido'::text, 'cerrado'::text])));
alter table public.carritos add constraint carritos_pkey PRIMARY KEY (id);
alter table public.clientes add constraint clientes_pkey PRIMARY KEY (id);
alter table public.clientes add constraint clientes_telefono_key UNIQUE (telefono);
alter table public.clientes_historial add constraint clientes_historial_pkey PRIMARY KEY (id);
alter table public.compras add constraint compras_pkey PRIMARY KEY (id);
alter table public.gastos add constraint gastos_pkey PRIMARY KEY (id);
alter table public.inventario_detalle add constraint inventario_detalle_pkey PRIMARY KEY (id);
alter table public.inventario_sesiones add constraint inventario_sesiones_pkey PRIMARY KEY (id);
alter table public.lives add constraint lives_pkey PRIMARY KEY (id);
alter table public.pagos add constraint pagos_estado_check CHECK ((estado = ANY (ARRAY['pendiente'::text, 'confirmado'::text])));
alter table public.pagos add constraint pagos_metodo_check CHECK ((metodo = ANY (ARRAY['Yape'::text, 'Plin'::text, 'Transferencia'::text])));
alter table public.pagos add constraint pagos_pkey PRIMARY KEY (id);
alter table public.pedidos add constraint pedidos_estado_check CHECK ((estado = ANY (ARRAY['acumulando'::text, 'listo_envio'::text, 'pago_pendiente'::text, 'pago_parcial'::text, 'pago_completo'::text, 'empaquetado'::text, 'en_camino'::text, 'entregado'::text, 'cancelado'::text])));
alter table public.pedidos add constraint pedidos_numero_key UNIQUE (numero);
alter table public.pedidos add constraint pedidos_pkey PRIMARY KEY (id);
alter table public.pedidos_historial add constraint pedidos_historial_pkey PRIMARY KEY (id);
alter table public.prenda_stock add constraint prenda_stock_pkey PRIMARY KEY (id);
alter table public.prenda_stock add constraint prenda_stock_prenda_id_talla_color_key UNIQUE (prenda_id, talla, color);
alter table public.prenda_variantes add constraint prenda_variantes_pkey PRIMARY KEY (id);
alter table public.prenda_variantes add constraint prenda_variantes_prenda_id_talla_color_key UNIQUE (prenda_id, talla, color);
alter table public.prendas add constraint prendas_codigo_key UNIQUE (codigo);
alter table public.prendas add constraint prendas_pkey PRIMARY KEY (id);
alter table public.shalom_agencias add constraint shalom_agencias_pkey PRIMARY KEY (nombre);
alter table public.shalom_pro_destinos add constraint shalom_pro_destinos_pkey PRIMARY KEY (agencia);
alter table public.usuarios add constraint usuarios_pkey PRIMARY KEY (id);
alter table public.usuarios add constraint usuarios_rol_check CHECK ((rol = ANY (ARRAY['admin'::text, 'operador'::text])));
alter table public.usuarios add constraint usuarios_username_key UNIQUE (username);

-- ── 3. RELACIONES ENTRE TABLAS ─────────────────────────────────────
alter table public.brasil_items add constraint brasil_items_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES brasil_pedidos(id) ON DELETE CASCADE;
alter table public.carrito_items add constraint carrito_items_carrito_id_fkey FOREIGN KEY (carrito_id) REFERENCES carritos(id) ON DELETE CASCADE;
alter table public.carrito_items add constraint carrito_items_prenda_id_fkey FOREIGN KEY (prenda_id) REFERENCES prendas(id);
alter table public.carritos add constraint carritos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE;
alter table public.clientes_historial add constraint clientes_historial_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES clientes(id);
alter table public.compras add constraint compras_prenda_id_fkey FOREIGN KEY (prenda_id) REFERENCES prendas(id);
alter table public.inventario_detalle add constraint inventario_detalle_sesion_id_fkey FOREIGN KEY (sesion_id) REFERENCES inventario_sesiones(id) ON DELETE CASCADE;
alter table public.pagos add constraint pagos_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE;
alter table public.pedidos add constraint pedidos_carrito_id_fkey FOREIGN KEY (carrito_id) REFERENCES carritos(id);
alter table public.pedidos add constraint pedidos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES clientes(id);
alter table public.pedidos_historial add constraint pedidos_historial_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES pedidos(id);
alter table public.prenda_stock add constraint prenda_stock_prenda_id_fkey FOREIGN KEY (prenda_id) REFERENCES prendas(id) ON DELETE CASCADE;
alter table public.prenda_variantes add constraint prenda_variantes_prenda_id_fkey FOREIGN KEY (prenda_id) REFERENCES prendas(id) ON DELETE CASCADE;

-- ── 4. ÍNDICES ─────────────────────────────────────────────────────
CREATE INDEX IF NOT EXISTS brasil_items_pedido_idx ON public.brasil_items USING btree (pedido_id);
CREATE INDEX IF NOT EXISTS idx_items_carrito ON public.carrito_items USING btree (carrito_id);
CREATE INDEX IF NOT EXISTS idx_carritos_cliente ON public.carritos USING btree (cliente_id);
CREATE INDEX IF NOT EXISTS idx_clientes_telefono ON public.clientes USING btree (telefono);
CREATE INDEX IF NOT EXISTS idx_pagos_pedido ON public.pagos USING btree (pedido_id);
CREATE INDEX IF NOT EXISTS idx_pedidos_cliente ON public.pedidos USING btree (cliente_id);
CREATE INDEX IF NOT EXISTS idx_pedidos_estado ON public.pedidos USING btree (estado);
CREATE INDEX IF NOT EXISTS idx_variantes_prenda ON public.prenda_variantes USING btree (prenda_id);

-- ── 5. FUNCIONES Y TRIGGERS (cálculos automáticos) ─────────────────
-- Número de pedido automático: PED-2026-0001. CAMBIA 'PED' por 3 letras de tu marca.
CREATE OR REPLACE FUNCTION public.generar_numero_pedido()
 RETURNS trigger LANGUAGE plpgsql AS $function$
declare
  prefijo text := 'PED';
  ultimo integer;
begin
  select coalesce(max(cast(substring(numero from '^[A-Z]+-\d{4}-(\d+)') as integer)), 0)
  into ultimo from pedidos
  where numero like prefijo || '-' || to_char(now(), 'YYYY') || '-%';
  new.numero := prefijo || '-' || to_char(now(), 'YYYY') || '-' || lpad((ultimo + 1)::text, 4, '0');
  return new;
end;
$function$;

CREATE OR REPLACE FUNCTION public.actualizar_total_carrito()
 RETURNS trigger LANGUAGE plpgsql AS $function$
begin
  update carritos
  set total = (select coalesce(sum(precio_unitario), 0) from carrito_items where carrito_id = coalesce(new.carrito_id, old.carrito_id)),
      actualizado_en = now()
  where id = coalesce(new.carrito_id, old.carrito_id);
  return new;
end;
$function$;

CREATE OR REPLACE FUNCTION public.actualizar_monto_pagado()
 RETURNS trigger LANGUAGE plpgsql AS $function$
declare
  total_pagado numeric;
  pedido_total numeric;
begin
  select coalesce(sum(monto), 0) into total_pagado from pagos where pedido_id = new.pedido_id and estado = 'confirmado';
  select total into pedido_total from pedidos where id = new.pedido_id;
  update pedidos
  set monto_pagado = total_pagado,
      estado = case
        when total_pagado >= pedido_total then 'pago_completo'
        when total_pagado > 0            then 'pago_parcial'
        else                                  'pago_pendiente'
      end,
      actualizado_en = now()
  where id = new.pedido_id;
  return new;
end;
$function$;

CREATE TRIGGER trigger_numero_pedido BEFORE INSERT ON public.pedidos FOR EACH ROW WHEN (((new.numero IS NULL) OR (new.numero = ''::text))) EXECUTE FUNCTION generar_numero_pedido();
CREATE TRIGGER trigger_total_carrito_insert AFTER INSERT ON public.carrito_items FOR EACH ROW EXECUTE FUNCTION actualizar_total_carrito();
CREATE TRIGGER trigger_total_carrito_delete AFTER DELETE ON public.carrito_items FOR EACH ROW EXECUTE FUNCTION actualizar_total_carrito();
CREATE TRIGGER trigger_monto_pagado AFTER INSERT OR UPDATE ON public.pagos FOR EACH ROW EXECUTE FUNCTION actualizar_monto_pagado();

-- ── 6. PERMISOS (igual que el CRM original: sin RLS, acceso con la llave pública) ──
-- Supabase puede activar RLS solo en tablas nuevas y bloquear todo (error 42501).
-- Aquí lo desactivamos en todas, como funciona el CRM original.
-- ⚠ Esto significa que quien tenga la llave pública puede leer/escribir las tablas.
--   Para un sistema que se vende a terceras, endurecer con login real + RLS (fase aparte).
alter table public.asistencia disable row level security;
alter table public.brasil_compras disable row level security;
alter table public.brasil_gastos disable row level security;
alter table public.brasil_items disable row level security;
alter table public.brasil_pedidos disable row level security;
alter table public.brasil_productos disable row level security;
alter table public.carrito_items disable row level security;
alter table public.carritos disable row level security;
alter table public.clientes disable row level security;
alter table public.clientes_historial disable row level security;
alter table public.compras disable row level security;
alter table public.gastos disable row level security;
alter table public.inventario_detalle disable row level security;
alter table public.inventario_sesiones disable row level security;
alter table public.lives disable row level security;
alter table public.pagos disable row level security;
alter table public.pedidos disable row level security;
alter table public.pedidos_historial disable row level security;
alter table public.prenda_stock disable row level security;
alter table public.prenda_variantes disable row level security;
alter table public.prendas disable row level security;
alter table public.shalom_agencias disable row level security;
alter table public.shalom_pro_destinos disable row level security;
alter table public.usuarios disable row level security;
grant usage on schema public to anon, authenticated;
grant all on all tables in schema public to anon, authenticated, service_role;
alter default privileges in schema public grant all on tables to anon, authenticated, service_role;

-- ── 7. FOTOS DE BOLETAS SHALOM (espacio de almacenamiento) ─────────
insert into storage.buckets (id, name, public) values ('boletas-shalom','boletas-shalom',true) on conflict do nothing;
create policy "boletas_anon" on storage.objects for all to anon
  using (bucket_id='boletas-shalom') with check (bucket_id='boletas-shalom');
