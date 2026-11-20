maxfragmentationmemory_reserved = "125"
maxmemory_delta                 = "125"
maxmemory_reserved              = "125"

postgres_pitr = {
  env               = "aat"
  name              = "tax-tribunals-infrastructure-pitr"
  restore_time      = "2026-11-03T11:30:00Z"
  import_object_ids = {}
  #  import_object_ids = {
  #    "DTS Platform Operations PostgreSQL Admin Access" = "3c52c98b-07a3-4a97-92b9-298e86bb1ca9"
  #    "jenkins-aat-mi"                                  = "14b22215-46e6-48a9-8681-e8cefe66236a"
  #    "jenkins-cftptl-intsvc-mi"                        = "ca6d5085-485a-417d-8480-c3cefa29df31"
  #  }
}
postgres_use_pitr = true
