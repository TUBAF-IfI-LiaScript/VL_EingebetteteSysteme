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
    toUInt(value) {
        let ret = 0;
        for (let i = 0; i < value.length; i++) if (value[i]) ret |= (1 << i);
        return ret;
    }
    parseFromUInt(n,leng) {
        let ret = [];
        for (let i = 0; i < leng; i++) ret.push(((n >> i) & 1) === 1);
        return ret;
    }
}
//output length: length of x
BitsDatatype.sum = function(x,y,carry) {
    let ret = [];
    for (let i = 0; i < x.length; i++) {
        let b = y[i];
        if (b === undefined) b = false;
        ret.push(xor(xor(x[i],b),carry));
        carry = x[i] && b || x[i] && carry || b && carry;
    }
    return ret;
}

BitsDatatype.increment = function(x) {
    let carry = true;
    let ret = [];
    for (let i = 0; i < x.length; i++) {
        ret.push(xor(x[i],carry));
        carry = x[i] && carry;
    }
    return ret;
}
/*
class WordsDatatype extends Datatype {
    constructor(size,wordDatatype) {
        this._size = size;
        this._wordDatatype = wordDatatype;
    }
    getName() {
        return "words:" + this._size + ":" + this._wordDatatype.getName();
    }
    is(value) {
        if (!(value instanceof Array)) return false;
        if (value.length !== this._size) return false;
        for (let w of value) this._wordDatatype.check(b);
        return true;
    }
}

class BitsWordsDatatype extends WordsDatatype {
    constructor(size,bitsLength) {
        super(size,new BitsDatatype(bitsLength));
    }
    toLinesString(value, reverse) {
        if (value.length === 0) return "";
        let ret = "";
        for (let i = 0; i < value.length; i++) {
            if (i > 1) ret += "\n";
            ret += this._wordDatatype.to01String(value[i],reverse);
        }
    }
    parseLinesString(linesString, reverse) {
        let li = linesString.split("\n");
        let words = [];
        for (let l of li) ret.push(this._wordDatatype.parseFrom01String(l));
        this.check(words);
        return words;
    }
}
*/
class ElementOfSetDatatype extends Datatype {
    constructor(elements,setName) {
        super();
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

class FreeDatatype extends Datatype {
    constructor() {
        super();
    }
    getName() {
        return "free";
    }
    is(value) {
        return true;
    }
    getDefaultValue() {
        return undefined;
    }
}
FreeDatatype.STATIC = new FreeDatatype();
