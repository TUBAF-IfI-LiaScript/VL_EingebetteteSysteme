class WebInterfaceFjangComponent extends FjangComponent {
    constructor() {
        super();
    }
    getHtmlElement() {
        throw new Error("WebInterfaceFjangComponent.getHtmlElement() is abstract");
    }
}

class BitIO extends WebInterfaceFjangComponent {
    constructor(readonly,checkboxClassName) {
        super();
        let current = this;
        this.bitNode = new FjangNode(BitDatatype.STATIC);
        this.elmnt = document.createElement("input");
        this.elmnt.type = "checkbox";
        this.elmnt.className = checkboxClassName;
        this.elmnt.disabled = readonly;
        this.elmnt.onchange = function() {
            current.bitNode.set(BitDatatype.STATIC.parse(current.elmnt.checked));
        }
    }
    getNodes() {
        return [this.bitNode];
    }
    getHtmlElement() {
        return this.elmnt;
    }
    tick() {
        this.elmnt.checked = this.bitNode.get();
    }
}

class BitsIO extends WebInterfaceFjangComponent {
    constructor(bitLength,readonly,checkboxClassName,spanClassName) {
        super();
        let bdt = new BitsDatatype(bitLength);
        this.bitsNode = new FjangNode(bdt);
        let current = this;
        this.elmnt = document.createElement("span");
        this.elmnt.className = spanClassName;
        this.bdt = bdt;
        this.bitsElmnts = [];
        this.bitLength = bitLength;
        for (let i = 0; i < bitLength; i++) {
            let b = document.createElement("input");
            b.type = "checkbox";
            b.className = checkboxClassName;
            b.disabled = readonly;
            b.onchange = function() {
                current.onchange();
            }
            this.bitsElmnts.push(b);
        }
        for (let i = this.bitsElmnts.length-1; i >= 0; i--) this.elmnt.appendChild(this.bitsElmnts[i]);
    }
    getNodes() {
        return [this.bitsNode];
    }
    onchange() {
        let arr = [];
        for (let b of this.bitsElmnts) arr.push(b.checked);
        this.bitsNode.set(this.bdt.parseFromArray(arr));
    }
    getHtmlElement() {
        return this.elmnt;
    }
    tick() {
        let v = this.bitsNode.get();
        for (let i = 0; i < this.bitLength; i++) this.bitsElmnts[i].checked = v[i];
    }
}
class Bits10IO extends WebInterfaceFjangComponent {
    constructor(bitLength,readonly,inputTextClassName) {
        super();
        let bdt = new BitsDatatype(bitLength);
        this.bitsNode = new FjangNode(bdt);
        let current = this;
        this.bdt = bdt;
        this.elmnt = document.createElement("input");
        this.elmnt.type = "text";
        this.elmnt.className = inputTextClassName;
        this.elmnt.disabled = readonly;
        this.focus = false;
        this.elmnt.onchange = function() {
            try {
                let v = bdt.parseFrom01String(current.elmnt.value,true);
                bdt.check(v);
                current.bitsNode.set(v);
            } catch (e) {
                current.elmnt.value = current.bdt.to01String(current.bitsNode.get(),true);
            }
            
        }
        this.elmnt.onfocus = function() {
            current.focus = true;
        }
        this.elmnt.addEventListener("focusout",function() {
            current.focus = false;
        });
    }
    getNodes() {
        return [this.bitsNode];
    }
    getHtmlElement() {
        return this.elmnt;
    }
    tick() {
        if (this.focus) return;
        this.elmnt.value = this.bdt.to01String(this.bitsNode.get(),true);
    }
}



class ElementOfSetIO extends WebInterfaceFjangComponent {
    constructor(elements,readonly,selectClassName) {
        super();
        let eosdt = new ElementOfSetDatatype(elements);
        this.eosNode = new FjangNode(eosdt);
        let current = this;
        this.elmnt = document.createElement("select");
        this.elmnt.disabled = readonly;
        this.elmnt.className = selectClassName;
        for (let el of elements) {
            let o = document.createElement("option");
            o.value = el;
            o.appendChild(document.createTextNode(el));
            this.elmnt.appendChild(o);
        }
        this.elmnt.value = elements[0];
        this.elmnt.onchange = function() {
            current.eosNode.set(current.elmnt.value);
        }
    }
    getNodes() {
        return [this.eosNode];
    }
    getHtmlElement() {
        return this.elmnt;
    }
    tick() {
        this.elmnt.value = this.eosNode.get();
    }
}
