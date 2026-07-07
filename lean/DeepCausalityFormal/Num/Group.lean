/-
SPDX-License-Identifier: MIT
Copyright (c) 2023 - 2026. The DeepCausality Authors and Contributors. All Rights Reserved.

Exemplar 2 — foundational group laws (Num layer).

Mirrors the Rust trait `deep_causality_num::Group`, a blanket impl over
`AddGroup` (see `deep_causality_num/src/algebra/group.rs`).
These laws explicitly state the axioms of an algebraic group under addition.

Rust witness: `deep_causality_num/tests/algebra/group_tests.rs`.
-/

import Mathlib.Algebra.Group.Defs

namespace DeepCausalityFormal.Num

/-- Associativity of the additive group operation: `(a + b) + c = a + (b + c)`.

    THEOREM_MAP: `num.group.assoc` -/
theorem add_group_assoc {G : Type*} [AddGroup G] (a b c : G) :
    (a + b) + c = a + (b + c) :=
  add_assoc a b c

/-- Identity Element of the additive group: `a + 0 = a` and `0 + a = a`.

    THEOREM_MAP: `num.group.identity` -/
theorem add_group_identity {G : Type*} [AddGroup G] (a : G) :
    a + 0 = a ∧ 0 + a = a :=
  ⟨add_zero a, zero_add a⟩

/-- Inverse Element of the additive group: `a + (-a) = 0` and `(-a) + a = 0`.
    Denoted mathematically as `a⁻¹` but implemented here as `-a` for addition.

    THEOREM_MAP: `num.group.inverse` -/
theorem add_group_inverse {G : Type*} [AddGroup G] (a : G) :
    a + -a = 0 ∧ -a + a = 0 :=
  ⟨add_neg_cancel a, neg_add_cancel a⟩

end DeepCausalityFormal.Num
