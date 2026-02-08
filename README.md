# Mainframes Playground

A structured collection of hands-on samples for IBM mainframe technologies: COBOL, JCL, REXX, VSAM, Db2, IMS, MQ, and common utilities.

This repo is designed to be a **playground** where you can explore small, focused examples and see how the pieces fit together on z/OS.

---

## Folder structure

```text
mainframe-playground/
 ├─ README.md
 ├─ cobol/
 │   ├─ basic/
 │   │   ├─ hello_world.cbl
 │   │   ├─ arithmetic_example.cbl
 │   │   └─ control_statements.cbl
 │   ├─ file_handling/
 │   │   ├─ seq_read_write.cbl
 │   │   ├─ indexed_read_write.cbl
 │   │   └─ relative_file_example.cbl
 │   ├─ vsam/
 │   │   ├─ vsam_ksds_read.cbl
 │   │   ├─ vsam_ksds_update.cbl
 │   │   └─ vsam_rrds_example.cbl
 │   ├─ db2/
 │   │   ├─ cobol_db2_select.cbl
 │   │   ├─ cobol_db2_insert.cbl
 │   │   └─ cobol_db2_cursor.cbl
 │   ├─ ims/
 │   │   ├─ cobol_ims_gn.cbl
 │   │   ├─ cobol_ims_isrt.cbl
 │   │   └─ cobol_ims_ghu_repl.cbl
 │   ├─ mq/
 │   │   ├─ cobol_mq_put.cbl
 │   │   └─ cobol_mq_get.cbl
 │   ├─ utilities/
 │   │   ├─ cobol_string_handling.cbl
 │   │   └─ cobol_table_example.cbl
 │   └─ compiler_options/
 │       ├─ readme_cobol_compilation.md
 │       └─ sample_compile_parms.txt
 │
 ├─ jcl/
 │   ├─ basics/
 │   │   ├─ jcl_hello_world.jcl
 │   │   └─ jcl_job_structure_explained.md
 │   ├─ cobol_compile_link_run/
 │   │   ├─ jcl_compile_cobol.jcl
 │   │   ├─ jcl_linkedit_cobol.jcl
 │   │   └─ jcl_run_cobol.jcl
 │   ├─ db2/
 │   │   ├─ jcl_cobol_db2_prep_bind.jcl
 │   │   ├─ jcl_db2_load_utility.jcl
 │   │   └─ jcl_db2_unload_utility.jcl
 │   ├─ ims/
 │   │   ├─ jcl_ims_region_start.jcl
 │   │   └─ jcl_ims_bmp_sample.jcl
 │   ├─ mq/
 │   │   ├─ jcl_mq_batch_program.jcl
 │   │   └─ jcl_mq_utility_example.jcl
 │   ├─ sort_join/
 │   │   ├─ jcl_sort_simple.jcl
 │   │   ├─ jcl_sort_sumfields.jcl
 │   │   └─ jcl_join_keys_example.jcl
 │   ├─ vsam/
 │   │   ├─ jcl_vsam_define_ksds.jcl
 │   │   ├─ jcl_vsam_repro_load.jcl
 │   │   └─ jcl_vsam_print.jcl
 │   ├─ utilities/
 │   │   ├─ jcl_iebgener_example.jcl
 │   │   ├─ jcl_iefbr14_allocate_delete.jcl
 │   │   └─ jcl_idcams_examples.jcl
 │   └─ docs/
 │       └─ how_jcl_interacts_with_mainframe.md
 │
 ├─ rexx/
 │   ├─ basic/
 │   │   ├─ hello_rexx.rex
 │   │   ├─ loop_example.rex
 │   │   └─ tso_command_example.rex
 │   ├─ tso_automation/
 │   │   ├─ allocate_dataset.rex
 │   │   └─ submit_jcl_rexx.rex
 │   └─ ispf/
 │       ├─ panel_driven_example.rex
 │       └─ simple_ispf_dialog.rex
 │
 └─ docs/
     ├─ mainframe_overview.md
     ├─ cobol_overview.md
     ├─ db2_overview.md
     ├─ ims_overview.md
     ├─ mq_overview.md
     └─ vsam_overview.md


## Getting started

1. Clone the repo.
2. Pick a topic (e.g. `cobol/basic/hello_world.cbl` and `jcl/cobol_compile_link_run/jcl_run_cobol.jcl`).
3. Adapt dataset names, load libraries, and subsystem names for your site.
4. Compile and run on z/OS or in your emulator/sandbox.

Contributions are welcome: add new examples, improve comments, or suggest new topics via issues/PRs.

## Useful link for 
- TABLES/ARRAY in COBOL
- SEARCH
- SEARCH ALL

- https://www.tutorialspoint.com/cobol/cobol_table_processing.htm

