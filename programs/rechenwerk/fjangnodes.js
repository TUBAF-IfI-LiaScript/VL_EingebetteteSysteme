class FjangGraph {
    constructor(nodes) {
        if (nodes === undefined) nodes = [];
        this.nodes = nodes;
    }
    isInGraph(n) {
        return this.nodes.indexOf(n) !== -1;
    }
    addNode(n) {
        if (this.isInGraph(n)) return;
        this.nodes.push(n);
    }
    removeNode(n) {
        if (!this.isInGraph(n)) return;
        for (let i = 0; i < this.nodes.length; i++) {
            if (this.nodes[i] === n) {
                this.nodes.splice(i,1);
                i--;
            }
        }
    }
    addNodes(ns) {
        for (let n of ns) this.addNode(n);
    }
    removeNodes(ns) {
        for (let n of ns) this.removeNode(n);
    }
    tick() {
        for (let n of this.nodes) n.tick();
    }
}

class FjangNode {
    constructor(datatype) {
        this._datatype = datatype;
        this._valueOld = datatype.getDefaultValue();
        this._valueNew = datatype.getDefaultValue();
        this._connectedNodes = [];
        this._setBlocker = false;
//        this._wasSetedOld = true;//true, if set() 
//        this._wasSetedNew = true;
    }
    get() {
        return this._valueOld;
    }
    set(value) {
        if (this._setBlocker) return;
        
        this._datatype.check(value);//throws DatatypeError, if value is not valid 
        
        this._valueNew = value;
        
        this._setBlocker = true;
        this._send();
        this._setBlocker = false;
    }
    tick() {
        this._valueOld = this._valueNew;
//        this._wasSetedOld = this._wasSetedNew;
//        this._wasSetedNew = false;
    }
/*    wasSeted() {
        return this._wasSetedOld;
    }*/
    isConnected(n) {
        return this._connectedNodes.indexOf(n) !== -1;
    }
    addConnection(n) {
        if (!(n instanceof FjangNode)) throw new Error("FjangNode.addConnection(n): n is not a FjangNode!");
        if (n === this) return;
        if (this.isConnected(n)) return;
        this._connectedNodes.push(n);
    }
    removeConnection(n) {
        if (!this.isConnected(n)) return;
        for (let i = 0; i < this._connectedNodes.length; i++) {
            if (this._connectedNodes[i] === n) {
                this._connectedNodes.splice(i,1);
                i--;
            }
        }
    }
    
    _send() {
        for (let n of this._connectedNodes) n.set(this._valueNew);
    }
    
    static connectFromTo(a,b) {
        a.addConnection(b);
    }
    static connectBi(a,b) {
        a.addConnection(b);
        b.addConnection(a);
    }
    static connectOnlyFromTo(a,b) {
        a.addConnection(b);
        b.removeConnection(a);
    }
    static removeConnectionFromTo(a,b) {
        a.removeConnection(b);
    }
    static removeConnectionBi(a,b) {
        a.removeConnection(b);
        b.removeConnection(a);
    }
}

//or interface
class Datatype {
    constructor() {
        
    }
    getName() {
        return "abstract datatype";
    }
    //abstract, returns true, if value is valid
    is(value) {
        throw new Error("Datatype.is() is abstract");
    }
    
    //throws DatatypeError, if value is not valid, otherwise returns undefined
    getDefaultValue() {
        throw new Error("Datatype.getDefaultValue() is abstract");
    }
    
    check(value) {
        if (!this.is(value)) throw new DatatypeError(this,value,"Check Failed (value=" + value + ", datatype=" + this.getName() + ")");
    }
}

//example:
/*
 *    class BitDatatype extends Datatype {
 *        constructor() {
 *            super();
 *        }
 *        getName() {
 *            return "bit";
 *        }
 *        is(value) {
 *            return value === true || value === false;
 *        }
 *        parse(x) {
 *            return x ? true : false;
 *        }
 *    }
*/

class DatatypeError extends Error {
    constructor(datatype,invalidValue,msg) {
        if (msg === undefined) msg = "Invalid Data";
        super(msg);
        this.datatype = datatype;
        this.invalidValue = invalidValue;
    }
}
