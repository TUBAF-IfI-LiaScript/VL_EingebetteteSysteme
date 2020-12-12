class FjangComponent {
    constructor() {
    
    }
    getNodes() {
        throw new Error("FjangComponent.getNodes() is abstract");
    }
    tick() {
        
    }
}

class FjangWorld {
    constructor(components) {
        this._components = components;
        this._graph = new FjangGraph();
        for (let c of components) this._graph.addNodes(c.getNodes());
    }
    tick() {
        this._graph.tick();
        for (let c of this._components) c.tick();
//        this._graph.tick();
    }
}
