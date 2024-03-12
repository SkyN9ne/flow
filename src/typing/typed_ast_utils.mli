(*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

(**
 * Find the first typed AST entry for "type-at-pos" related queries. A query
 * succeeds if the location is within the range of a symbol in the AST. The kinds
 * of symbols handled here are:
 *  - identifiers
 *  - literal object keys
 *  - `this`, `super`
 *  - private property names
 *
 * The first part of the return is the full span of the matching symbol.
 *
 * It's convenient to use Loc.t as the input query, since this is usually called
 * in direct response to a client query, which are typically concrete locations.
 *)
val find_type_at_pos_annotation :
  Context.t ->
  (ALoc.t, ALoc.t * Type.t) Flow_ast.Program.t ->
  Loc.t ->
  (Loc.t * bool * Type.t) option

val typed_ast_to_map :
  (ALoc.t, ALoc.t * Type.t) Flow_polymorphic_ast_mapper.Ast.Program.t ->
  Type.t Loc_collections.ALocMap.t

val typed_ast_to_list :
  (ALoc.t, ALoc.t * Type.t) Flow_polymorphic_ast_mapper.Ast.Program.t -> (ALoc.t * Type.t) list

val error_mapper : (ALoc.t, ALoc.t, ALoc.t, ALoc.t * Type.t) Flow_polymorphic_ast_mapper.mapper

val placeholder_mapper :
  Context.t -> (ALoc.t, ALoc.t, ALoc.t, ALoc.t * Type.t) Flow_polymorphic_ast_mapper.mapper

val unimplemented_mapper :
  (ALoc.t, ALoc.t, ALoc.t, ALoc.t * Type.t) Flow_polymorphic_ast_mapper.mapper

val unchecked_mapper : (ALoc.t, ALoc.t, ALoc.t, ALoc.t * Type.t) Flow_polymorphic_ast_mapper.mapper

val untyped_ast_mapper :
  (ALoc.t, ALoc.t * Type.t, ALoc.t, ALoc.t) Flow_polymorphic_ast_mapper.mapper
