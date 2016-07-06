#include <postgres.h>
#include <fmgr.h>
#include <catalog/pg_type.h>
#include <utils/builtins.h>
#include <utils/rangetypes.h>

PG_MODULE_MAGIC;

#include "inetrange_canonical.c"

