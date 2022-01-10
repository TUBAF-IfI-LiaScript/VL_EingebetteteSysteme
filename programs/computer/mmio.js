class Mmio {
    constructor(words, wordDatatype, offset, size) {
        this.wordDatatype = wordDatatype;
        this.offset = offset;
        this.size = size;
        this.words = words;
    }
    read(a) {
        a = Math.round(a*1);
        if (a >= 0 && a < this.size) return this.words[a+this.offset];
        return undefined;
    }
    write(v,a) {
        a = Math.round(a*1);
        if (a >= this.offset && a < this.size) this.words[a+this.offset] = v;
    }
    
    
    tick() {
        
    }
}

class MemOutput extends Mmio {
    constructor(words, bitsLength, offset, size) {
        super(words,new BitsDatatype(bitsLength), offset, size);
        this.textArea = document.createElement("textarea");
        this.textArea.value = "Memory:";
        this.textArea.readOnly = true;
        this.textArea.cols = 28;
        this.textArea.rows = this.size+2;
    }
    getHtmlElement() {
        return this.textArea;
    }
    
    tick() {
        let s = "Memory:";
        for (let i = 0; i < this.size; i++) {
            let absoluteAdr = (i + this.offset);
            s += "\n" + this.wordDatatype.to01String(this.read(i),true) + " (" + absoluteAdr + ")";
        }
        this.textArea.value = s;
    }
}
/*
class DecimalOutput extends Mmio {
    constructor(words, bitsLength, offset) {
        
    }
}
*/

class ImageOutRGBA16 extends Mmio {
    // binär: aaaabbbbggggrrrr
    constructor(words, offset, width, height, zoom, noAlpha) {
        super(words, new BitsDatatype(16), offset, width*height);
        this.width = width;
        this.height = height;
        this.canvas = document.createElement("canvas");
        this.canvas.width = width*zoom;
        this.canvas.height = height*zoom;
        this.ctx = this.canvas.getContext("2d");
 //       this.idata = this.ctx.createImageData(width, height);
        this.zoom = zoom;
        this.noAlpha = noAlpha;
    }
    getHtmlElement() {
        return this.canvas;
    }
    tick() {
        this.ctx.clearRect(0,0,this.width,this.height);
        for (let y = 0; y < this.height; y++) for (let x = 0; x < this.width; x++) {
            let i = y*this.width + x;
            let bits = this.read(i);
            let c = this.wordDatatype.toUInt(bits);
            let r = (c & 0xf)*17;
            let g = ((c >> 4) & 0xf)*17;
            let b = ((c >> 8) & 0xf)*17;
            let a = 255;
            if (!this.noAlpha) a = ((c >> 12) & 0xf)*17;
            this.ctx.fillStyle = "rgba(" + r + "," + g + "," + b + "," + a/255 + ")";
            this.ctx.fillRect(x*this.zoom,y*this.zoom,this.zoom,this.zoom);
/*            for (let yZoom = 0; yZoom < this.zoom; yZoom++) for (let xZoom = 0; xZoom < this.zoom; xZoom++) {
                let j = ((y*this.zoom + yZoom)*this.width*this.zoom + (x*this.zoom + xZoom))*4;
                this.idata.data[j] = r;
                this.idata.data[j+1] = g;
                this.idata.data[j+2] = b;
                this.idata.data[j+3] = a;
                alert(x + " " + y + " " + xZoom + " " + yZoom + " " + j/4);
            }*/
        }
 //       this.ctx.putImageData(this.idata,0,0);
    }
}
