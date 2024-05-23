## Related work

- [Schema language for both RDF and LPGs](https://www.lassila.org/publications/2024/lassila-kgc-2024-schemas-final.pdf)
- [PG-Schema: Schemas for Property Graphs](https://dl.acm.org/doi/10.1145/3589778)


## Guiding thoughts

- The scope of a GraphType is based on the [BoundedContext](https://martinfowler.com/bliki/BoundedContext.html) of the information beeing represented, contrasting the scoping of an ontology which is based on conceptual cohesion
- NodeTypes describe **how** information is represented (structure, constraints, variability), contrasting the use of classes that describe **what** a node represents

### Concept mapping

| PG-Schema | RDF | Comment |
| --- | --- | --- |
| GraphType | `prof:Profile` with `prof:ResourceDescriptor` | https://www.w3.org/TR/dx-prof/#conceptualmodel |
| NodeType | `sh:NodeShape` & `rdfs:Class` | https://www.w3.org/TR/shacl/#implicit-targetClass |
| NodeLabel | `rdfs:Class` | |

* **What** is this node?
  * Q: semantics
  * A: Class
* **How** is this node?
  * Q: structure, constraints
  * A: NodeType, NodeShape

### Design decisions

- Keep PG-Schemas distinction between NodeLabel and NodeType
- Use the GraphType as container and namespace for local scoped elements (eg. for labels, properties)


## Generating the profile

The buildscript can be run using the [zazukoians/node-java-jena](https://hub.docker.com/r/zazukoians/node-java-jena) docker image.

That image has all the necessary tools.

```sh
docker run --rm -it -v $(pwd):/app zazukoians/node-java-jena:v5 ./build.sh
```

The build reads the input file *in-example-schema.ttl* and generates two files from it, one filtered down to the triples of the resulting profile and one for debugging purposes:

- *out-profile.ttl*
- *out-debug.ttl*


## Scope of the example

The input file *in-example-schema.ttl* has ...
- One NodeType `PersonType` that is using RDF classes and RDF properties from existing ontology
- One NodeType `CustomerType` that is introducing local classes and properties

The following visualization shows what the resulting profile contains:

![graphtype-as-resourcedescriptor](doc/graphtype-as-resourcedescriptor.png?raw=true "The generated profile looks like this ...")