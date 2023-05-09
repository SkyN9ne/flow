(*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

(* TODO: add TypesForbidden (disables types even on files with @flow) and
   TypesAllowedByDefault (enables types even on files without @flow, but allows
   something like @noflow to disable them) *)
type types_mode =
  | TypesAllowed
  | TypesForbiddenByDefault

type t = {
  parse_types_mode: types_mode;
  parse_use_strict: bool;
  parse_munge_underscores: bool;
  parse_module_ref_prefix: string option;
  parse_module_ref_prefix_LEGACY_INTEROP: string option;
  parse_facebook_fbt: string option;
  parse_suppress_types: SSet.t;
  parse_max_literal_len: int;
  parse_component_syntax: bool;
  parse_exact_by_default: bool;
  parse_enable_enums: bool;
  parse_enable_relay_integration: bool;
  parse_relay_integration_excludes: Str.regexp list;
  parse_relay_integration_module_prefix: string option;
  parse_relay_integration_module_prefix_includes: Str.regexp list;
  parse_node_main_fields: string list;
  parse_distributed: bool;
  parse_enable_conditional_types: bool;
  parse_enable_mapped_types: bool;
  parse_tuple_enhancements: bool;
}

let make_parsing_options ?(types_mode = TypesAllowed) ?use_strict options =
  let use_strict =
    match use_strict with
    | Some use_strict -> use_strict
    | None -> Options.modules_are_use_strict options
  in
  let module_ref_prefix = Options.haste_module_ref_prefix options in
  let module_ref_prefix_LEGACY_INTEROP = Options.haste_module_ref_prefix_LEGACY_INTEROP options in
  let facebook_fbt = Options.facebook_fbt options in
  {
    parse_types_mode = types_mode;
    parse_use_strict = use_strict;
    parse_munge_underscores = Options.should_munge_underscores options;
    parse_module_ref_prefix = module_ref_prefix;
    parse_module_ref_prefix_LEGACY_INTEROP = module_ref_prefix_LEGACY_INTEROP;
    parse_facebook_fbt = facebook_fbt;
    parse_suppress_types = Options.suppress_types options;
    parse_max_literal_len = Options.max_literal_length options;
    parse_component_syntax = Options.component_syntax options;
    parse_exact_by_default = Options.exact_by_default options;
    parse_enable_enums = Options.enums options;
    parse_enable_relay_integration = Options.enable_relay_integration options;
    parse_relay_integration_excludes = Options.relay_integration_excludes options;
    parse_relay_integration_module_prefix = Options.relay_integration_module_prefix options;
    parse_relay_integration_module_prefix_includes =
      Options.relay_integration_module_prefix_includes options;
    parse_node_main_fields = Options.node_main_fields options;
    parse_distributed = Options.distributed options;
    parse_enable_conditional_types = Options.conditional_type options;
    parse_enable_mapped_types = Options.mapped_type options;
    parse_tuple_enhancements = Options.tuple_enhancements options;
  }
