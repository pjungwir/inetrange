Datum inetrange_canonical(PG_FUNCTION_ARGS);
PG_FUNCTION_INFO_V1(inetrange_canonical);

/**
 * Returns a canonical version of an inetrange.
 * by Paul A. Jungwirth
 */
Datum
inetrange_canonical(PG_FUNCTION_ARGS)
{
  RangeType  *r = PG_GETARG_RANGE(0);
  TypeCacheEntry *typcache;
  RangeBound  lower;
  RangeBound  upper;
  bool    empty;

  typcache = range_get_typcache(fcinfo, RangeTypeGetOid(r));

  range_deserialize(typcache, r, &lower, &upper, &empty);

  if (empty) PG_RETURN_RANGE(r);

  if (!lower.infinite && !lower.inclusive) {
    lower.val = DirectFunctionCall2(inetpl, lower.val, Int64GetDatum(1));
    lower.inclusive = true;
  }

  if (!upper.infinite && !upper.inclusive) {
    upper.val = DirectFunctionCall2(inetmi_int8, upper.val, Int64GetDatum(1));
    upper.inclusive = true;
  }

  PG_RETURN_RANGE(range_serialize(typcache, &lower, &upper, false));
}
