class BitDatatype extends Datatype {
    constructor() {
        super();
    }
    getName() {
        return "bit";
    }
    is(value) {
        return value === true || value === false;
    }
    getDefaultValue() {
        return false;
    }
    
    parse(x) {
        return x ? true : false;
    }
}
BitDatatype.STATIC = new BitDatatype();

class BitsDatatype extends Datatype {
    constructor(bitsLength) {
        super();
        this._bitsLength = bitsLength;
    }
    getName() {
        return "bits:" + this._bitsLength;
    }
    is(value) {
        if (!(value instanceof Array)) return false;
        if (value.length !== this._bitsLength) return false;
        for (let b of value) BitDatatype.STATIC.check(b);
        return true;
    }
    getDefaultValue() {
        let ret = [];
        for (let i = 0; i < this._bitsLength; i++) ret.push(false);
        return ret;
    }
    
    getBitsLength() {
        return this._bitsLength;
    }
    parseFromArray(arr) {
        let ret = [];
        for (let i = 0; i < this._bitsLength; i++) ret.push(BitDatatype.STATIC.parse(arr[i]));
        return ret;
    }
    parseFrom01String(str,reverse) {
        let bits = [];
        for (let c of str) {
            bits.push(c === "1");
        }
        if (reverse) bits.reverse();
        this.check(bits);
        return bits;
    }
    to01String(value,reverse) {
        let ret = "";
        for (let i = 0; i < this._bitsLength; i++) ret += value[i] ? "1" : "0";
        if (reverse) ret = ret.split("").reverse().join("");
        return ret;
    }
}

class ElementOfSetDatatype extends Datatype {
    constructor(elements,setName) {
        super();
        console.log(elements,setName);
        if (setName === undefined) setName = "set";
        this._elements = elements;
        this._setName = setName;
    }
    getName() {
        return "element of " + this.setName;
    }
    is(value) {
        return this._elements.indexOf(value) !== -1;
    }
    getDefaultValue() {
        return this._elements[0];
    }
    
    getElements() {
        return this._elements;
    }
}
