[![Donate via Stripe](https://img.shields.io/badge/Donate-Stripe-green.svg)](https://buy.stripe.com/00gbJZ0OdcNs9zi288)<br>
[![Donate via Bitcoin](https://img.shields.io/badge/Donate-Bitcoin-green.svg)](bitcoin:37fsp7qQKU8XoHZGRQvVzQVP8FrEJ73cSJ)<br>
[![Donate via Paypal](https://img.shields.io/badge/Donate-Paypal-green.svg)](https://buy.stripe.com/00gbJZ0OdcNs9zi288)

Module system, for chopping up and reassembling code.
This forms a DAG of each module within the code, then when requested, it returns only what modules are necessary, in corret dependency order.

I made this after my OpenCL GPU simulation code was getting so large that the build times on it were climbing into the minutes realm.  I realized the CL compiler I was using wasn't so tuned for time, and that it was compiling every function regardless of whether it was being used or not.
So I made this tool and reduce the time by a factor of 100x or so, from minutes to seconds.  I use it pretty extensively in my [Hydrodynamics in OpenCL and LuaJIT](https://github.com/thenumbernine/hydro-cl-lua) project.

API:

```
local Modules = require 'modules'
local modules = Modules()

modules:add{
	name = <name>,
	depends = {<dep1>, <dep2>, ...},
	typecode = [[...]],
	structs = {<struct1>, <struct2>, ...},
	headercode = [[...]],
	code = [[...]],
}
```

The `structs` arg, and struct objects, are not yet in the repo, so don't worry about them.

Using markup:

```
//// MODULE_NAME: <name>
//// MODULE_DEPENDS: <dep1> <dep2> ...
```

Every `MODULE_NAME` macro defines the start of a new module in the markup.

Names cannot have spaces in them, dependency markup is space-separated.
If you want to insert type code, header code, or body code into your markup, you can distinguish each like so:

```
//// MODULE_TYPE:

<type code> ...

//// MODULE_HEADER:

<header code> ...

//// MODULE_CODE:

<code> ...

```

From there, code is requested and generated using the following API:

`modules:getTypeHeader(<mod1>, <mod2>, ...)` = returns typecode + structs

`modules:getHeader(<mod1>, <mod2>, ...)` = returns typecode + structs + header

`modules:getCodeAndHeader(<mod1>, <mod2>, ...)` = returns typecode + structs + header + code

Another useful function:

`modules:getDependentModules(<mod1>, <mod2>, ...)` = returns a `table` of all modules dependent on the modules provided.
