circuit IndependenceDemo :
  module Queue :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, count : UInt<3>}
  
    cmem ram : { flip data : UInt<8>} [4] @[Decoupled.scala 217:16]
    reg enq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 220:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 222:33]
    node _T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 223:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 223:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 224:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 228:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 229:8]
      _T_3.data <= io.enq.bits.data @[Decoupled.scala 229:24]
      node wrap = eq(enq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip
    when do_deq : @[Decoupled.scala 232:17]
      node wrap_1 = eq(deq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 235:16]
    when _T_8 : @[Decoupled.scala 235:28]
      maybe_full <= do_enq @[Decoupled.scala 236:16]
      skip
    node _T_9 = eq(empty, UInt<1>("h0")) @[Decoupled.scala 239:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 239:16]
    node _T_10 = eq(full, UInt<1>("h0")) @[Decoupled.scala 240:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 240:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 241:21]
    io.deq.bits.data <= _T_11.data @[Decoupled.scala 241:15]
    when io.enq.valid : @[Decoupled.scala 244:25]
      io.deq.valid <= UInt<1>("h1") @[Decoupled.scala 244:40]
      skip
    when empty : @[Decoupled.scala 245:18]
      io.deq.bits.data <= io.enq.bits.data @[Decoupled.scala 246:19]
      do_deq <= UInt<1>("h0") @[Decoupled.scala 247:14]
      when io.deq.ready : @[Decoupled.scala 248:27]
        do_enq <= UInt<1>("h0") @[Decoupled.scala 248:36]
        skip
      skip
    when io.deq.ready : @[Decoupled.scala 253:25]
      io.enq.ready <= UInt<1>("h1") @[Decoupled.scala 253:40]
      skip
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 256:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 256:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 258:32]
    node _T_14 = mux(_T_13, UInt<3>("h4"), UInt<1>("h0")) @[Decoupled.scala 258:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 258:62]
    io.count <= _T_15 @[Decoupled.scala 258:14]

  module Queue_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, count : UInt<3>}
  
    cmem ram : { flip data : UInt<8>} [4] @[Decoupled.scala 217:16]
    reg enq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 220:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 222:33]
    node _T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 223:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 223:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 224:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 228:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 229:8]
      _T_3.data <= io.enq.bits.data @[Decoupled.scala 229:24]
      node wrap = eq(enq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip
    when do_deq : @[Decoupled.scala 232:17]
      node wrap_1 = eq(deq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 235:16]
    when _T_8 : @[Decoupled.scala 235:28]
      maybe_full <= do_enq @[Decoupled.scala 236:16]
      skip
    node _T_9 = eq(empty, UInt<1>("h0")) @[Decoupled.scala 239:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 239:16]
    node _T_10 = eq(full, UInt<1>("h0")) @[Decoupled.scala 240:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 240:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 241:21]
    io.deq.bits.data <= _T_11.data @[Decoupled.scala 241:15]
    when io.enq.valid : @[Decoupled.scala 244:25]
      io.deq.valid <= UInt<1>("h1") @[Decoupled.scala 244:40]
      skip
    when empty : @[Decoupled.scala 245:18]
      io.deq.bits.data <= io.enq.bits.data @[Decoupled.scala 246:19]
      do_deq <= UInt<1>("h0") @[Decoupled.scala 247:14]
      when io.deq.ready : @[Decoupled.scala 248:27]
        do_enq <= UInt<1>("h0") @[Decoupled.scala 248:36]
        skip
      skip
    when io.deq.ready : @[Decoupled.scala 253:25]
      io.enq.ready <= UInt<1>("h1") @[Decoupled.scala 253:40]
      skip
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 256:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 256:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 258:32]
    node _T_14 = mux(_T_13, UInt<3>("h4"), UInt<1>("h0")) @[Decoupled.scala 258:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 258:62]
    io.count <= _T_15 @[Decoupled.scala 258:14]

  module DecoupledIODemo_1 :
    input clock : Clock
    input reset : Reset
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    inst Queue_1 of Queue_1 @[SimpleChiselAbstraction.scala 259:39]
    inst Queue of Queue @[SimpleChiselAbstraction.scala 258:38]
    wire n_reg : UInt<8> @[Independence.scala 16:21]
    reg reg : UInt, clock with :
      reset => (UInt<1>("h0"), reg) @[Independence.scala 17:22]
    reg <= n_reg @[Independence.scala 17:22]
    ctrl.in.ready <= UInt<1>("h1") @[Independence.scala 19:19]
    node _T = mux(ctrl.in.valid, in.data, UInt<1>("h0")) @[Independence.scala 20:17]
    n_reg <= _T @[Independence.scala 20:11]
    ctrl.out.valid <= UInt<1>("h1") @[Independence.scala 21:20]
    out.data <= reg @[Independence.scala 22:14]
    Queue.clock <= clock
    Queue.reset <= reset
    Queue_1.clock <= clock
    Queue_1.reset <= reset
    Queue.io.enq.valid <= ctrl.in.valid @[SimpleChiselAbstraction.scala 260:39]
    ctrl.in.ready <= Queue.io.enq.ready @[SimpleChiselAbstraction.scala 261:24]
    Queue_1.io.deq.ready <= ctrl.out.ready @[SimpleChiselAbstraction.scala 262:40]
    ctrl.out.valid <= Queue_1.io.deq.valid @[SimpleChiselAbstraction.scala 263:25]
    Queue.io.enq.bits.data <= in.data @[SimpleChiselAbstraction.scala 264:21]
    out.data <= Queue_1.io.deq.bits.data @[SimpleChiselAbstraction.scala 265:22]

  module Queue_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, count : UInt<3>}
  
    cmem ram : { flip data : UInt<8>} [4] @[Decoupled.scala 217:16]
    reg enq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 220:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 222:33]
    node _T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 223:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 223:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 224:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 228:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 229:8]
      _T_3.data <= io.enq.bits.data @[Decoupled.scala 229:24]
      node wrap = eq(enq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip
    when do_deq : @[Decoupled.scala 232:17]
      node wrap_1 = eq(deq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 235:16]
    when _T_8 : @[Decoupled.scala 235:28]
      maybe_full <= do_enq @[Decoupled.scala 236:16]
      skip
    node _T_9 = eq(empty, UInt<1>("h0")) @[Decoupled.scala 239:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 239:16]
    node _T_10 = eq(full, UInt<1>("h0")) @[Decoupled.scala 240:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 240:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 241:21]
    io.deq.bits.data <= _T_11.data @[Decoupled.scala 241:15]
    when io.enq.valid : @[Decoupled.scala 244:25]
      io.deq.valid <= UInt<1>("h1") @[Decoupled.scala 244:40]
      skip
    when empty : @[Decoupled.scala 245:18]
      io.deq.bits.data <= io.enq.bits.data @[Decoupled.scala 246:19]
      do_deq <= UInt<1>("h0") @[Decoupled.scala 247:14]
      when io.deq.ready : @[Decoupled.scala 248:27]
        do_enq <= UInt<1>("h0") @[Decoupled.scala 248:36]
        skip
      skip
    when io.deq.ready : @[Decoupled.scala 253:25]
      io.enq.ready <= UInt<1>("h1") @[Decoupled.scala 253:40]
      skip
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 256:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 256:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 258:32]
    node _T_14 = mux(_T_13, UInt<3>("h4"), UInt<1>("h0")) @[Decoupled.scala 258:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 258:62]
    io.count <= _T_15 @[Decoupled.scala 258:14]

  module Queue_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, count : UInt<3>}
  
    cmem ram : { flip data : UInt<8>} [4] @[Decoupled.scala 217:16]
    reg enq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 220:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 222:33]
    node _T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 223:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 223:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 224:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 228:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 229:8]
      _T_3.data <= io.enq.bits.data @[Decoupled.scala 229:24]
      node wrap = eq(enq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip
    when do_deq : @[Decoupled.scala 232:17]
      node wrap_1 = eq(deq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 235:16]
    when _T_8 : @[Decoupled.scala 235:28]
      maybe_full <= do_enq @[Decoupled.scala 236:16]
      skip
    node _T_9 = eq(empty, UInt<1>("h0")) @[Decoupled.scala 239:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 239:16]
    node _T_10 = eq(full, UInt<1>("h0")) @[Decoupled.scala 240:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 240:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 241:21]
    io.deq.bits.data <= _T_11.data @[Decoupled.scala 241:15]
    when io.enq.valid : @[Decoupled.scala 244:25]
      io.deq.valid <= UInt<1>("h1") @[Decoupled.scala 244:40]
      skip
    when empty : @[Decoupled.scala 245:18]
      io.deq.bits.data <= io.enq.bits.data @[Decoupled.scala 246:19]
      do_deq <= UInt<1>("h0") @[Decoupled.scala 247:14]
      when io.deq.ready : @[Decoupled.scala 248:27]
        do_enq <= UInt<1>("h0") @[Decoupled.scala 248:36]
        skip
      skip
    when io.deq.ready : @[Decoupled.scala 253:25]
      io.enq.ready <= UInt<1>("h1") @[Decoupled.scala 253:40]
      skip
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 256:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 256:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 258:32]
    node _T_14 = mux(_T_13, UInt<3>("h4"), UInt<1>("h0")) @[Decoupled.scala 258:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 258:62]
    io.count <= _T_15 @[Decoupled.scala 258:14]

  module DecoupledIODemo_2 :
    input clock : Clock
    input reset : Reset
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    inst Queue_1 of Queue_3 @[SimpleChiselAbstraction.scala 259:39]
    inst Queue of Queue_2 @[SimpleChiselAbstraction.scala 258:38]
    wire n_reg : UInt<8> @[Independence.scala 30:21]
    reg reg : UInt, clock with :
      reset => (UInt<1>("h0"), reg) @[Independence.scala 31:22]
    reg <= n_reg @[Independence.scala 31:22]
    ctrl.in.ready <= ctrl.in.valid @[Independence.scala 33:19]
    node _T = mux(ctrl.in.valid, in.data, UInt<1>("h0")) @[Independence.scala 34:17]
    n_reg <= _T @[Independence.scala 34:11]
    ctrl.out.valid <= UInt<1>("h1") @[Independence.scala 35:20]
    out.data <= reg @[Independence.scala 36:14]
    Queue.clock <= clock
    Queue.reset <= reset
    Queue_1.clock <= clock
    Queue_1.reset <= reset
    Queue.io.enq.valid <= ctrl.in.valid @[SimpleChiselAbstraction.scala 260:39]
    ctrl.in.ready <= Queue.io.enq.ready @[SimpleChiselAbstraction.scala 261:24]
    Queue_1.io.deq.ready <= ctrl.out.ready @[SimpleChiselAbstraction.scala 262:40]
    ctrl.out.valid <= Queue_1.io.deq.valid @[SimpleChiselAbstraction.scala 263:25]
    Queue.io.enq.bits.data <= in.data @[SimpleChiselAbstraction.scala 264:21]
    out.data <= Queue_1.io.deq.bits.data @[SimpleChiselAbstraction.scala 265:22]

  module Queue_4 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, count : UInt<3>}
  
    cmem ram : { flip data : UInt<8>} [4] @[Decoupled.scala 217:16]
    reg enq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 220:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 222:33]
    node _T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 223:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 223:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 224:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 228:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 229:8]
      _T_3.data <= io.enq.bits.data @[Decoupled.scala 229:24]
      node wrap = eq(enq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip
    when do_deq : @[Decoupled.scala 232:17]
      node wrap_1 = eq(deq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 235:16]
    when _T_8 : @[Decoupled.scala 235:28]
      maybe_full <= do_enq @[Decoupled.scala 236:16]
      skip
    node _T_9 = eq(empty, UInt<1>("h0")) @[Decoupled.scala 239:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 239:16]
    node _T_10 = eq(full, UInt<1>("h0")) @[Decoupled.scala 240:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 240:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 241:21]
    io.deq.bits.data <= _T_11.data @[Decoupled.scala 241:15]
    when io.enq.valid : @[Decoupled.scala 244:25]
      io.deq.valid <= UInt<1>("h1") @[Decoupled.scala 244:40]
      skip
    when empty : @[Decoupled.scala 245:18]
      io.deq.bits.data <= io.enq.bits.data @[Decoupled.scala 246:19]
      do_deq <= UInt<1>("h0") @[Decoupled.scala 247:14]
      when io.deq.ready : @[Decoupled.scala 248:27]
        do_enq <= UInt<1>("h0") @[Decoupled.scala 248:36]
        skip
      skip
    when io.deq.ready : @[Decoupled.scala 253:25]
      io.enq.ready <= UInt<1>("h1") @[Decoupled.scala 253:40]
      skip
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 256:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 256:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 258:32]
    node _T_14 = mux(_T_13, UInt<3>("h4"), UInt<1>("h0")) @[Decoupled.scala 258:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 258:62]
    io.count <= _T_15 @[Decoupled.scala 258:14]

  module Queue_5 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, count : UInt<3>}
  
    cmem ram : { flip data : UInt<8>} [4] @[Decoupled.scala 217:16]
    reg enq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 220:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 222:33]
    node _T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 223:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 223:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 224:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 228:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 229:8]
      _T_3.data <= io.enq.bits.data @[Decoupled.scala 229:24]
      node wrap = eq(enq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip
    when do_deq : @[Decoupled.scala 232:17]
      node wrap_1 = eq(deq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 235:16]
    when _T_8 : @[Decoupled.scala 235:28]
      maybe_full <= do_enq @[Decoupled.scala 236:16]
      skip
    node _T_9 = eq(empty, UInt<1>("h0")) @[Decoupled.scala 239:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 239:16]
    node _T_10 = eq(full, UInt<1>("h0")) @[Decoupled.scala 240:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 240:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 241:21]
    io.deq.bits.data <= _T_11.data @[Decoupled.scala 241:15]
    when io.enq.valid : @[Decoupled.scala 244:25]
      io.deq.valid <= UInt<1>("h1") @[Decoupled.scala 244:40]
      skip
    when empty : @[Decoupled.scala 245:18]
      io.deq.bits.data <= io.enq.bits.data @[Decoupled.scala 246:19]
      do_deq <= UInt<1>("h0") @[Decoupled.scala 247:14]
      when io.deq.ready : @[Decoupled.scala 248:27]
        do_enq <= UInt<1>("h0") @[Decoupled.scala 248:36]
        skip
      skip
    when io.deq.ready : @[Decoupled.scala 253:25]
      io.enq.ready <= UInt<1>("h1") @[Decoupled.scala 253:40]
      skip
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 256:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 256:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 258:32]
    node _T_14 = mux(_T_13, UInt<3>("h4"), UInt<1>("h0")) @[Decoupled.scala 258:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 258:62]
    io.count <= _T_15 @[Decoupled.scala 258:14]

  module DecoupledIODemo_3 :
    input clock : Clock
    input reset : Reset
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    inst Queue_1 of Queue_5 @[SimpleChiselAbstraction.scala 259:39]
    inst Queue of Queue_4 @[SimpleChiselAbstraction.scala 258:38]
    wire n_reg : UInt<8> @[Independence.scala 45:21]
    reg reg : UInt, clock with :
      reset => (UInt<1>("h0"), reg) @[Independence.scala 46:22]
    reg <= n_reg @[Independence.scala 46:22]
    ctrl.in.ready <= UInt<1>("h1") @[Independence.scala 48:19]
    node _T = mux(ctrl.in.valid, in.data, UInt<1>("h0")) @[Independence.scala 49:17]
    n_reg <= _T @[Independence.scala 49:11]
    ctrl.out.valid <= ctrl.out.ready @[Independence.scala 50:20]
    out.data <= reg @[Independence.scala 51:14]
    Queue.clock <= clock
    Queue.reset <= reset
    Queue_1.clock <= clock
    Queue_1.reset <= reset
    Queue.io.enq.valid <= ctrl.in.valid @[SimpleChiselAbstraction.scala 260:39]
    ctrl.in.ready <= Queue.io.enq.ready @[SimpleChiselAbstraction.scala 261:24]
    Queue_1.io.deq.ready <= ctrl.out.ready @[SimpleChiselAbstraction.scala 262:40]
    ctrl.out.valid <= Queue_1.io.deq.valid @[SimpleChiselAbstraction.scala 263:25]
    Queue.io.enq.bits.data <= in.data @[SimpleChiselAbstraction.scala 264:21]
    out.data <= Queue_1.io.deq.bits.data @[SimpleChiselAbstraction.scala 265:22]

  module Queue_6 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, count : UInt<3>}
  
    cmem ram : { flip data : UInt<8>} [4] @[Decoupled.scala 217:16]
    reg enq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 220:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 222:33]
    node _T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 223:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 223:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 224:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 228:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 229:8]
      _T_3.data <= io.enq.bits.data @[Decoupled.scala 229:24]
      node wrap = eq(enq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip
    when do_deq : @[Decoupled.scala 232:17]
      node wrap_1 = eq(deq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 235:16]
    when _T_8 : @[Decoupled.scala 235:28]
      maybe_full <= do_enq @[Decoupled.scala 236:16]
      skip
    node _T_9 = eq(empty, UInt<1>("h0")) @[Decoupled.scala 239:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 239:16]
    node _T_10 = eq(full, UInt<1>("h0")) @[Decoupled.scala 240:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 240:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 241:21]
    io.deq.bits.data <= _T_11.data @[Decoupled.scala 241:15]
    when io.enq.valid : @[Decoupled.scala 244:25]
      io.deq.valid <= UInt<1>("h1") @[Decoupled.scala 244:40]
      skip
    when empty : @[Decoupled.scala 245:18]
      io.deq.bits.data <= io.enq.bits.data @[Decoupled.scala 246:19]
      do_deq <= UInt<1>("h0") @[Decoupled.scala 247:14]
      when io.deq.ready : @[Decoupled.scala 248:27]
        do_enq <= UInt<1>("h0") @[Decoupled.scala 248:36]
        skip
      skip
    when io.deq.ready : @[Decoupled.scala 253:25]
      io.enq.ready <= UInt<1>("h1") @[Decoupled.scala 253:40]
      skip
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 256:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 256:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 258:32]
    node _T_14 = mux(_T_13, UInt<3>("h4"), UInt<1>("h0")) @[Decoupled.scala 258:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 258:62]
    io.count <= _T_15 @[Decoupled.scala 258:14]

  module Queue_7 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, count : UInt<3>}
  
    cmem ram : { flip data : UInt<8>} [4] @[Decoupled.scala 217:16]
    reg enq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 220:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 222:33]
    node _T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 223:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 223:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 224:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 228:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 229:8]
      _T_3.data <= io.enq.bits.data @[Decoupled.scala 229:24]
      node wrap = eq(enq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip
    when do_deq : @[Decoupled.scala 232:17]
      node wrap_1 = eq(deq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 235:16]
    when _T_8 : @[Decoupled.scala 235:28]
      maybe_full <= do_enq @[Decoupled.scala 236:16]
      skip
    node _T_9 = eq(empty, UInt<1>("h0")) @[Decoupled.scala 239:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 239:16]
    node _T_10 = eq(full, UInt<1>("h0")) @[Decoupled.scala 240:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 240:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 241:21]
    io.deq.bits.data <= _T_11.data @[Decoupled.scala 241:15]
    when io.enq.valid : @[Decoupled.scala 244:25]
      io.deq.valid <= UInt<1>("h1") @[Decoupled.scala 244:40]
      skip
    when empty : @[Decoupled.scala 245:18]
      io.deq.bits.data <= io.enq.bits.data @[Decoupled.scala 246:19]
      do_deq <= UInt<1>("h0") @[Decoupled.scala 247:14]
      when io.deq.ready : @[Decoupled.scala 248:27]
        do_enq <= UInt<1>("h0") @[Decoupled.scala 248:36]
        skip
      skip
    when io.deq.ready : @[Decoupled.scala 253:25]
      io.enq.ready <= UInt<1>("h1") @[Decoupled.scala 253:40]
      skip
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 256:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 256:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 258:32]
    node _T_14 = mux(_T_13, UInt<3>("h4"), UInt<1>("h0")) @[Decoupled.scala 258:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 258:62]
    io.count <= _T_15 @[Decoupled.scala 258:14]

  module DecoupledIODemo_4 :
    input clock : Clock
    input reset : Reset
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    inst Queue_1 of Queue_7 @[SimpleChiselAbstraction.scala 259:39]
    inst Queue of Queue_6 @[SimpleChiselAbstraction.scala 258:38]
    wire n_reg : UInt<8> @[Independence.scala 59:21]
    reg reg : UInt, clock with :
      reset => (UInt<1>("h0"), reg) @[Independence.scala 60:22]
    reg <= n_reg @[Independence.scala 60:22]
    node _T = add(in.data, UInt<1>("h1")) @[Independence.scala 63:38]
    node _T_1 = tail(_T, 1) @[Independence.scala 63:38]
    node next = mux(ctrl.in.valid, _T_1, UInt<1>("h0")) @[Independence.scala 63:19]
    ctrl.in.ready <= ctrl.out.ready @[Independence.scala 65:19]
    n_reg <= next @[Independence.scala 66:11]
    ctrl.out.valid <= UInt<1>("h1") @[Independence.scala 67:20]
    out.data <= reg @[Independence.scala 68:14]
    Queue.clock <= clock
    Queue.reset <= reset
    Queue_1.clock <= clock
    Queue_1.reset <= reset
    Queue.io.enq.valid <= ctrl.in.valid @[SimpleChiselAbstraction.scala 260:39]
    ctrl.in.ready <= Queue.io.enq.ready @[SimpleChiselAbstraction.scala 261:24]
    Queue_1.io.deq.ready <= ctrl.out.ready @[SimpleChiselAbstraction.scala 262:40]
    ctrl.out.valid <= Queue_1.io.deq.valid @[SimpleChiselAbstraction.scala 263:25]
    Queue.io.enq.bits.data <= in.data @[SimpleChiselAbstraction.scala 264:21]
    out.data <= Queue_1.io.deq.bits.data @[SimpleChiselAbstraction.scala 265:22]

  module Queue_8 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, count : UInt<3>}
  
    cmem ram : { flip data : UInt<8>} [4] @[Decoupled.scala 217:16]
    reg enq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 220:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 222:33]
    node _T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 223:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 223:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 224:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 228:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 229:8]
      _T_3.data <= io.enq.bits.data @[Decoupled.scala 229:24]
      node wrap = eq(enq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip
    when do_deq : @[Decoupled.scala 232:17]
      node wrap_1 = eq(deq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 235:16]
    when _T_8 : @[Decoupled.scala 235:28]
      maybe_full <= do_enq @[Decoupled.scala 236:16]
      skip
    node _T_9 = eq(empty, UInt<1>("h0")) @[Decoupled.scala 239:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 239:16]
    node _T_10 = eq(full, UInt<1>("h0")) @[Decoupled.scala 240:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 240:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 241:21]
    io.deq.bits.data <= _T_11.data @[Decoupled.scala 241:15]
    when io.enq.valid : @[Decoupled.scala 244:25]
      io.deq.valid <= UInt<1>("h1") @[Decoupled.scala 244:40]
      skip
    when empty : @[Decoupled.scala 245:18]
      io.deq.bits.data <= io.enq.bits.data @[Decoupled.scala 246:19]
      do_deq <= UInt<1>("h0") @[Decoupled.scala 247:14]
      when io.deq.ready : @[Decoupled.scala 248:27]
        do_enq <= UInt<1>("h0") @[Decoupled.scala 248:36]
        skip
      skip
    when io.deq.ready : @[Decoupled.scala 253:25]
      io.enq.ready <= UInt<1>("h1") @[Decoupled.scala 253:40]
      skip
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 256:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 256:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 258:32]
    node _T_14 = mux(_T_13, UInt<3>("h4"), UInt<1>("h0")) @[Decoupled.scala 258:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 258:62]
    io.count <= _T_15 @[Decoupled.scala 258:14]

  module Queue_9 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, count : UInt<3>}
  
    cmem ram : { flip data : UInt<8>} [4] @[Decoupled.scala 217:16]
    reg enq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 220:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 222:33]
    node _T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 223:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 223:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 224:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 228:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 229:8]
      _T_3.data <= io.enq.bits.data @[Decoupled.scala 229:24]
      node wrap = eq(enq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip
    when do_deq : @[Decoupled.scala 232:17]
      node wrap_1 = eq(deq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 235:16]
    when _T_8 : @[Decoupled.scala 235:28]
      maybe_full <= do_enq @[Decoupled.scala 236:16]
      skip
    node _T_9 = eq(empty, UInt<1>("h0")) @[Decoupled.scala 239:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 239:16]
    node _T_10 = eq(full, UInt<1>("h0")) @[Decoupled.scala 240:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 240:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 241:21]
    io.deq.bits.data <= _T_11.data @[Decoupled.scala 241:15]
    when io.enq.valid : @[Decoupled.scala 244:25]
      io.deq.valid <= UInt<1>("h1") @[Decoupled.scala 244:40]
      skip
    when empty : @[Decoupled.scala 245:18]
      io.deq.bits.data <= io.enq.bits.data @[Decoupled.scala 246:19]
      do_deq <= UInt<1>("h0") @[Decoupled.scala 247:14]
      when io.deq.ready : @[Decoupled.scala 248:27]
        do_enq <= UInt<1>("h0") @[Decoupled.scala 248:36]
        skip
      skip
    when io.deq.ready : @[Decoupled.scala 253:25]
      io.enq.ready <= UInt<1>("h1") @[Decoupled.scala 253:40]
      skip
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 256:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 256:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 258:32]
    node _T_14 = mux(_T_13, UInt<3>("h4"), UInt<1>("h0")) @[Decoupled.scala 258:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 258:62]
    io.count <= _T_15 @[Decoupled.scala 258:14]

  module DecoupledIODemo_5 :
    input clock : Clock
    input reset : Reset
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    inst Queue_1 of Queue_9 @[SimpleChiselAbstraction.scala 259:39]
    inst Queue of Queue_8 @[SimpleChiselAbstraction.scala 258:38]
    wire n_reg : UInt<8> @[Independence.scala 76:21]
    reg reg : UInt, clock with :
      reset => (UInt<1>("h0"), reg) @[Independence.scala 77:22]
    reg <= n_reg @[Independence.scala 77:22]
    node _T = eq(ctrl.in.valid, UInt<1>("h0")) @[Independence.scala 80:24]
    when _T : @[Independence.scala 80:36]
      ctrl.in.ready <= UInt<1>("h0") @[Independence.scala 81:23]
      skip
    else :
      node _T_1 = eq(ctrl.in.valid, UInt<1>("h1")) @[Independence.scala 83:29]
      when _T_1 : @[Independence.scala 83:40]
        ctrl.in.ready <= UInt<1>("h1") @[Independence.scala 84:23]
        skip
      else :
        ctrl.in.ready <= UInt<1>("h1") @[Independence.scala 86:23]
        skip
    node _T_2 = add(in.data, UInt<1>("h1")) @[Independence.scala 88:41]
    node _T_3 = tail(_T_2, 1) @[Independence.scala 88:41]
    node _T_4 = mux(ctrl.in.valid, _T_3, UInt<1>("h0")) @[Independence.scala 88:17]
    n_reg <= _T_4 @[Independence.scala 88:11]
    ctrl.out.valid <= UInt<1>("h1") @[Independence.scala 89:20]
    out.data <= reg @[Independence.scala 90:14]
    Queue.clock <= clock
    Queue.reset <= reset
    Queue_1.clock <= clock
    Queue_1.reset <= reset
    Queue.io.enq.valid <= ctrl.in.valid @[SimpleChiselAbstraction.scala 260:39]
    ctrl.in.ready <= Queue.io.enq.ready @[SimpleChiselAbstraction.scala 261:24]
    Queue_1.io.deq.ready <= ctrl.out.ready @[SimpleChiselAbstraction.scala 262:40]
    ctrl.out.valid <= Queue_1.io.deq.valid @[SimpleChiselAbstraction.scala 263:25]
    Queue.io.enq.bits.data <= in.data @[SimpleChiselAbstraction.scala 264:21]
    out.data <= Queue_1.io.deq.bits.data @[SimpleChiselAbstraction.scala 265:22]

  module Queue_10 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, count : UInt<3>}
  
    cmem ram : { flip data : UInt<8>} [4] @[Decoupled.scala 217:16]
    reg enq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 220:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 222:33]
    node _T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 223:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 223:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 224:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 228:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 229:8]
      _T_3.data <= io.enq.bits.data @[Decoupled.scala 229:24]
      node wrap = eq(enq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip
    when do_deq : @[Decoupled.scala 232:17]
      node wrap_1 = eq(deq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 235:16]
    when _T_8 : @[Decoupled.scala 235:28]
      maybe_full <= do_enq @[Decoupled.scala 236:16]
      skip
    node _T_9 = eq(empty, UInt<1>("h0")) @[Decoupled.scala 239:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 239:16]
    node _T_10 = eq(full, UInt<1>("h0")) @[Decoupled.scala 240:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 240:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 241:21]
    io.deq.bits.data <= _T_11.data @[Decoupled.scala 241:15]
    when io.enq.valid : @[Decoupled.scala 244:25]
      io.deq.valid <= UInt<1>("h1") @[Decoupled.scala 244:40]
      skip
    when empty : @[Decoupled.scala 245:18]
      io.deq.bits.data <= io.enq.bits.data @[Decoupled.scala 246:19]
      do_deq <= UInt<1>("h0") @[Decoupled.scala 247:14]
      when io.deq.ready : @[Decoupled.scala 248:27]
        do_enq <= UInt<1>("h0") @[Decoupled.scala 248:36]
        skip
      skip
    when io.deq.ready : @[Decoupled.scala 253:25]
      io.enq.ready <= UInt<1>("h1") @[Decoupled.scala 253:40]
      skip
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 256:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 256:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 258:32]
    node _T_14 = mux(_T_13, UInt<3>("h4"), UInt<1>("h0")) @[Decoupled.scala 258:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 258:62]
    io.count <= _T_15 @[Decoupled.scala 258:14]

  module Queue_11 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : { data : UInt<8>}}, count : UInt<3>}
  
    cmem ram : { flip data : UInt<8>} [4] @[Decoupled.scala 217:16]
    reg enq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg deq_ptr_value : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Counter.scala 29:33]
    reg maybe_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoupled.scala 220:27]
    node ptr_match = eq(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 222:33]
    node _T = eq(maybe_full, UInt<1>("h0")) @[Decoupled.scala 223:28]
    node empty = and(ptr_match, _T) @[Decoupled.scala 223:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 224:24]
    node _T_1 = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _T_1
    node _T_2 = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _T_2
    when do_enq : @[Decoupled.scala 228:17]
      infer mport _T_3 = ram[enq_ptr_value], clock @[Decoupled.scala 229:8]
      _T_3.data <= io.enq.bits.data @[Decoupled.scala 229:24]
      node wrap = eq(enq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_4 = add(enq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_5 = tail(_T_4, 1) @[Counter.scala 39:22]
      enq_ptr_value <= _T_5 @[Counter.scala 39:13]
      skip
    when do_deq : @[Decoupled.scala 232:17]
      node wrap_1 = eq(deq_ptr_value, UInt<2>("h3")) @[Counter.scala 38:24]
      node _T_6 = add(deq_ptr_value, UInt<1>("h1")) @[Counter.scala 39:22]
      node _T_7 = tail(_T_6, 1) @[Counter.scala 39:22]
      deq_ptr_value <= _T_7 @[Counter.scala 39:13]
      skip
    node _T_8 = neq(do_enq, do_deq) @[Decoupled.scala 235:16]
    when _T_8 : @[Decoupled.scala 235:28]
      maybe_full <= do_enq @[Decoupled.scala 236:16]
      skip
    node _T_9 = eq(empty, UInt<1>("h0")) @[Decoupled.scala 239:19]
    io.deq.valid <= _T_9 @[Decoupled.scala 239:16]
    node _T_10 = eq(full, UInt<1>("h0")) @[Decoupled.scala 240:19]
    io.enq.ready <= _T_10 @[Decoupled.scala 240:16]
    infer mport _T_11 = ram[deq_ptr_value], clock @[Decoupled.scala 241:21]
    io.deq.bits.data <= _T_11.data @[Decoupled.scala 241:15]
    when io.enq.valid : @[Decoupled.scala 244:25]
      io.deq.valid <= UInt<1>("h1") @[Decoupled.scala 244:40]
      skip
    when empty : @[Decoupled.scala 245:18]
      io.deq.bits.data <= io.enq.bits.data @[Decoupled.scala 246:19]
      do_deq <= UInt<1>("h0") @[Decoupled.scala 247:14]
      when io.deq.ready : @[Decoupled.scala 248:27]
        do_enq <= UInt<1>("h0") @[Decoupled.scala 248:36]
        skip
      skip
    when io.deq.ready : @[Decoupled.scala 253:25]
      io.enq.ready <= UInt<1>("h1") @[Decoupled.scala 253:40]
      skip
    node _T_12 = sub(enq_ptr_value, deq_ptr_value) @[Decoupled.scala 256:32]
    node ptr_diff = tail(_T_12, 1) @[Decoupled.scala 256:32]
    node _T_13 = and(maybe_full, ptr_match) @[Decoupled.scala 258:32]
    node _T_14 = mux(_T_13, UInt<3>("h4"), UInt<1>("h0")) @[Decoupled.scala 258:20]
    node _T_15 = or(_T_14, ptr_diff) @[Decoupled.scala 258:62]
    io.count <= _T_15 @[Decoupled.scala 258:14]

  module DecoupledIODemo_6 :
    input clock : Clock
    input reset : Reset
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
  
    inst Queue_1 of Queue_11 @[SimpleChiselAbstraction.scala 259:39]
    inst Queue of Queue_10 @[SimpleChiselAbstraction.scala 258:38]
    wire n_reg : UInt<8> @[Independence.scala 98:21]
    reg reg : UInt, clock with :
      reset => (UInt<1>("h0"), reg) @[Independence.scala 99:22]
    reg <= n_reg @[Independence.scala 99:22]
    ctrl.in.ready <= ctrl.out.ready @[Independence.scala 101:13]
    ctrl.out.valid <= ctrl.in.valid @[Independence.scala 101:13]
    node _T = add(in.data, UInt<1>("h1")) @[Independence.scala 102:41]
    node _T_1 = tail(_T, 1) @[Independence.scala 102:41]
    node _T_2 = mux(ctrl.in.valid, _T_1, UInt<1>("h0")) @[Independence.scala 102:17]
    n_reg <= _T_2 @[Independence.scala 102:11]
    out.data <= reg @[Independence.scala 103:14]
    Queue.clock <= clock
    Queue.reset <= reset
    Queue_1.clock <= clock
    Queue_1.reset <= reset
    Queue.io.enq.valid <= ctrl.in.valid @[SimpleChiselAbstraction.scala 260:39]
    ctrl.in.ready <= Queue.io.enq.ready @[SimpleChiselAbstraction.scala 261:24]
    Queue_1.io.deq.ready <= ctrl.out.ready @[SimpleChiselAbstraction.scala 262:40]
    ctrl.out.valid <= Queue_1.io.deq.valid @[SimpleChiselAbstraction.scala 263:25]
    Queue.io.enq.bits.data <= in.data @[SimpleChiselAbstraction.scala 264:21]
    out.data <= Queue_1.io.deq.bits.data @[SimpleChiselAbstraction.scala 265:22]

  module IndependenceDemo :
    input clock : Clock
    input reset : UInt<1>
    output in : { flip data : UInt<8>}
    input out : { flip data : UInt<8>}
    output ctrl : { in : { flip valid : UInt<1>, ready : UInt<1>}, flip out : { flip valid : UInt<1>, ready : UInt<1>}, flip clear : UInt<1>}
  
    inst com6 of DecoupledIODemo_6 @[Independence.scala 116:22]
    inst com5 of DecoupledIODemo_5 @[Independence.scala 115:22]
    inst com4 of DecoupledIODemo_4 @[Independence.scala 114:22]
    inst com3 of DecoupledIODemo_3 @[Independence.scala 113:22]
    inst com2 of DecoupledIODemo_2 @[Independence.scala 112:22]
    inst com1 of DecoupledIODemo_1 @[Independence.scala 111:22]
    com1.clock <= clock
    com1.reset <= reset
    com2.clock <= clock
    com2.reset <= reset
    com3.clock <= clock
    com3.reset <= reset
    com4.clock <= clock
    com4.reset <= reset
    com5.clock <= clock
    com5.reset <= reset
    com6.clock <= clock
    com6.reset <= reset
    wire w : { flip data : UInt<8>} @[Independence.scala 118:17]
    w.data <= UInt<3>("h4") @[Independence.scala 119:12]
    com1.ctrl.in.valid <= UInt<1>("h1") @[Independence.scala 121:24]
    com6.ctrl.out.ready <= UInt<1>("h1") @[Independence.scala 122:25]
    com1.in.data <= in.data
    com2.in.data <= com1.out.data
    com1.ctrl.out.ready <= com2.ctrl.in.ready @[IOInterface.scala 148:32]
    com2.ctrl.in.valid <= com1.ctrl.out.valid @[IOInterface.scala 149:28]
    com3.in.data <= com2.out.data
    com2.ctrl.out.ready <= com3.ctrl.in.ready @[IOInterface.scala 148:32]
    com3.ctrl.in.valid <= com2.ctrl.out.valid @[IOInterface.scala 149:28]
    com4.in.data <= com3.out.data
    com3.ctrl.out.ready <= com4.ctrl.in.ready @[IOInterface.scala 148:32]
    com4.ctrl.in.valid <= com3.ctrl.out.valid @[IOInterface.scala 149:28]
    com5.in.data <= com4.out.data
    com4.ctrl.out.ready <= com5.ctrl.in.ready @[IOInterface.scala 148:32]
    com5.ctrl.in.valid <= com4.ctrl.out.valid @[IOInterface.scala 149:28]
    com6.in.data <= com5.out.data
    com5.ctrl.out.ready <= com6.ctrl.in.ready @[IOInterface.scala 148:32]
    com6.ctrl.in.valid <= com5.ctrl.out.valid @[IOInterface.scala 149:28]
    out.data <= com6.out.data
    com1.ctrl.clear <= ctrl.clear @[Driver.scala 98:87]
    com2.ctrl.clear <= ctrl.clear @[Driver.scala 98:87]
    com3.ctrl.clear <= ctrl.clear @[Driver.scala 98:87]
    com4.ctrl.clear <= ctrl.clear @[Driver.scala 98:87]
    com5.ctrl.clear <= ctrl.clear @[Driver.scala 98:87]
    com6.ctrl.clear <= ctrl.clear @[Driver.scala 98:87]
