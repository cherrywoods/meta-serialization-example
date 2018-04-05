# 🚂Format
TrainFormat is a general example of MetaSerialization's usage. The example code includes a custom implementation of `MetaSupplier` and `Unwrapper` as well as implementations of `Serialization` and `Representation`. TrainFormat also features custom implementations of `Meta`, `KeyedContainerMeta` and `UnkeyedContainerMeta`, all based on a useless "train format" that looks something like this: 
```
🚂["someArrayProperty": -1>, "someDoubleProperty": "9543.43"]¬["1.": "43", "2.": "44"]
```
