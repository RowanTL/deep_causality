import Lake
open Lake DSL

require aesop from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.15.0"

package DeepCausalityFormal

@[default_target]
lean_lib DeepCausalityFormal
