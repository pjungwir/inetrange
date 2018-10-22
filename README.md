inetrange
=========

This is a Postgres extension to give you [ranges](https://www.postgresql.org/docs/current/static/rangetypes.html)
of [inet values](https://www.postgresql.org/docs/current/static/datatype-net-types.html).
I wrote a tutorial-style blog post about [using the Postgres `inet` type in ranges](http://illuminatedcomputing.com/posts/2016/06/inet-range/) that explains how you might build this extension "by hand", but since a small part of it requires C, it seems nicer to have it all packaged as an extension for people.


Installing
----------

This package installs like any Postgres extension. First say:

    make && sudo make install

You will need to have `pg_config` in your path,
but normally that is already the case.
You can check with `which pg_config`.

Then in the database of your choice say:

    CREATE EXTENSION inetrange;


Usage
-----

Once you've installed the extension,
you can do things like this:

    SELECT '1.0.1.1' <@ inetrange('1.0.0.0', '1.1.0.0', '[]');

or this:

    SELECT '[1.0.0.0,1.1.0.0]'::inetrange && '[1.0.1.0,2.2.2.2]'::inetrange;

You can also create exclusion constraints on `inetrange` columns:

    CREATE TABLE geoips (
      ips inetrange NOT NULL,
      country_code TEXT NOT NULL,
      latitude REAL NOT NULL,
      longitude REAL NOT NULL,
      CONSTRAINT geoips_dont_overlap
        EXCLUDE USING gist (ips WITH &&)
    );

Because the exclusion constraint auto-generates a GiST index,
you will also get fast lookups with operators like `<@`.

See Also
--------

You might also be interested in the [ip4r extension](https://github.com/RhodiumToad/ip4r).
