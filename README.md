Examples for MetaSerialization
==============================

This repository contains example project the should demostrate use cases and implementation examples for [MetaSerialization](https://www.github.com/cherrywoods/swift-meta-serialization). 

Contents
--------
 * TrainFormat
 * GenieFormat

TrainFormat
-----------

TrainFormat is a general example of MetaSerialization's usage. The example code includes a custom implementation of `MetaSupplier` and `Unwrapper` as well as implementations of `Serialization` and `Representation`. TrainFormat also features custom implementations of `Meta`, `KeyedContainerMeta` and `UnkeyedContainerMeta`, all based on a useless "train format" that looks something like this: 
```
🚂["someArrayProperty": -1>, "someDoubleProperty": "9543.43"]¬["1.": "43", "2.": "44"]
```

GenieFormat
-----------

GenieFormat is decoding only and therefor only includes an implementation of  `Unwrapper`.
This project should demonstrate MetaSerializations dynamic meta tree unwrapping feature.
This feature enables "interpreting" the meta tree during MetaDecoders work. Metas passed to a MetaDecoder can be replaced by new metas conforming to `DecodingKeyedContainerMeta`, `DecodingUnkeyedContainerMeta`, or `NilMeta`. More information about this can be found in the `Unwrapper` documentation.
