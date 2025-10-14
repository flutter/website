(function dartProgram(){function copyProperties(a,b){var s=Object.keys(a)
for(var r=0;r<s.length;r++){var q=s[r]
b[q]=a[q]}}function mixinPropertiesHard(a,b){var s=Object.keys(a)
for(var r=0;r<s.length;r++){var q=s[r]
if(!b.hasOwnProperty(q)){b[q]=a[q]}}}function mixinPropertiesEasy(a,b){Object.assign(b,a)}var z=function(){var s=function(){}
s.prototype={p:{}}
var r=new s()
if(!(Object.getPrototypeOf(r)&&Object.getPrototypeOf(r).p===s.prototype.p))return false
try{if(typeof navigator!="undefined"&&typeof navigator.userAgent=="string"&&navigator.userAgent.indexOf("Chrome/")>=0)return true
if(typeof version=="function"&&version.length==0){var q=version()
if(/^\d+\.\d+\.\d+\.\d+$/.test(q))return true}}catch(p){}return false}()
function inherit(a,b){a.prototype.constructor=a
a.prototype["$i"+a.name]=a
if(b!=null){if(z){Object.setPrototypeOf(a.prototype,b.prototype)
return}var s=Object.create(b.prototype)
copyProperties(a.prototype,s)
a.prototype=s}}function inheritMany(a,b){for(var s=0;s<b.length;s++){inherit(b[s],a)}}function mixinEasy(a,b){mixinPropertiesEasy(b.prototype,a.prototype)
a.prototype.constructor=a}function mixinHard(a,b){mixinPropertiesHard(b.prototype,a.prototype)
a.prototype.constructor=a}function lazy(a,b,c,d){var s=a
a[b]=s
a[c]=function(){if(a[b]===s){a[b]=d()}a[c]=function(){return this[b]}
return a[b]}}function lazyFinal(a,b,c,d){var s=a
a[b]=s
a[c]=function(){if(a[b]===s){var r=d()
if(a[b]!==s){A.pR(b)}a[b]=r}var q=a[b]
a[c]=function(){return q}
return q}}function makeConstList(a,b){if(b!=null)A.j(a,b)
a.$flags=7
return a}function convertToFastObject(a){function t(){}t.prototype=a
new t()
return a}function convertAllToFastObject(a){for(var s=0;s<a.length;++s){convertToFastObject(a[s])}}var y=0
function instanceTearOffGetter(a,b){var s=null
return a?function(c){if(s===null)s=A.qm(b)
return new s(c,this)}:function(){if(s===null)s=A.qm(b)
return new s(this,null)}}function staticTearOffGetter(a){var s=null
return function(){if(s===null)s=A.qm(a).prototype
return s}}var x=0
function tearOffParameters(a,b,c,d,e,f,g,h,i,j){if(typeof h=="number"){h+=x}return{co:a,iS:b,iI:c,rC:d,dV:e,cs:f,fs:g,fT:h,aI:i||0,nDA:j}}function installStaticTearOff(a,b,c,d,e,f,g,h){var s=tearOffParameters(a,true,false,c,d,e,f,g,h,false)
var r=staticTearOffGetter(s)
a[b]=r}function installInstanceTearOff(a,b,c,d,e,f,g,h,i,j){c=!!c
var s=tearOffParameters(a,false,c,d,e,f,g,h,i,!!j)
var r=instanceTearOffGetter(c,s)
a[b]=r}function setOrUpdateInterceptorsByTag(a){var s=v.interceptorsByTag
if(!s){v.interceptorsByTag=a
return}copyProperties(a,s)}function setOrUpdateLeafTags(a){var s=v.leafTags
if(!s){v.leafTags=a
return}copyProperties(a,s)}function updateTypes(a){var s=v.types
var r=s.length
s.push.apply(s,a)
return r}function updateHolder(a,b){copyProperties(b,a)
return a}var hunkHelpers=function(){var s=function(a,b,c,d,e){return function(f,g,h,i){return installInstanceTearOff(f,g,a,b,c,d,[h],i,e,false)}},r=function(a,b,c,d){return function(e,f,g,h){return installStaticTearOff(e,f,a,b,c,[g],h,d)}}
return{inherit:inherit,inheritMany:inheritMany,mixin:mixinEasy,mixinHard:mixinHard,installStaticTearOff:installStaticTearOff,installInstanceTearOff:installInstanceTearOff,_instance_0u:s(0,0,null,["$0"],0),_instance_1u:s(0,1,null,["$1"],0),_instance_2u:s(0,2,null,["$2"],0),_instance_0i:s(1,0,null,["$0"],0),_instance_1i:s(1,1,null,["$1"],0),_instance_2i:s(1,2,null,["$2"],0),_static_0:r(0,null,["$0"],0),_static_1:r(1,null,["$1"],0),_static_2:r(2,null,["$2"],0),makeConstList:makeConstList,lazy:lazy,lazyFinal:lazyFinal,updateHolder:updateHolder,convertToFastObject:convertToFastObject,updateTypes:updateTypes,setOrUpdateInterceptorsByTag:setOrUpdateInterceptorsByTag,setOrUpdateLeafTags:setOrUpdateLeafTags}}()
function initializeDeferredHunk(a){x=v.types.length
a(hunkHelpers,v,w,$)}var J={
uM(a,b,c,d){return{i:a,p:b,e:c,x:d}},
M3(a){var s,r,q,p,o,n=a[v.dispatchPropertyName]
if(n==null)if($.Bv==null){A.XD()
n=a[v.dispatchPropertyName]}if(n!=null){s=n.p
if(!1===s)return n.i
if(!0===s)return a
r=Object.getPrototypeOf(a)
if(s===r)return n.i
if(n.e===r)throw A.L(A.SY("Return interceptor for "+A.I(s(a,n))))}q=a.constructor
if(q==null)p=null
else{o=$.zm
if(o==null)o=$.zm=v.getIsolateTag("_$dart_js")
p=q[o]}if(p!=null)return p
p=A.A(a)
if(p!=null)return p
if(typeof a=="function")return B.DG
s=Object.getPrototypeOf(a)
if(s==null)return B.ZQ
if(s===Object.prototype)return B.ZQ
if(typeof q=="function"){o=$.zm
if(o==null)o=$.zm=v.getIsolateTag("_$dart_js")
Object.defineProperty(q,o,{value:B.vB,enumerable:false,writable:true,configurable:true})
return B.vB}return B.vB},
Ga(a){if(a<256)switch(a){case 9:case 10:case 11:case 12:case 13:case 32:case 133:case 160:return!0
default:return!1}switch(a){case 5760:case 8192:case 8193:case 8194:case 8195:case 8196:case 8197:case 8198:case 8199:case 8200:case 8201:case 8202:case 8232:case 8233:case 8239:case 8287:case 12288:case 65279:return!0
default:return!1}},
c1(a,b){var s,r
for(;b>0;b=s){s=b-1
r=a.charCodeAt(s)
if(r!==32&&r!==13&&!J.Ga(r))break}return b},
U6(a){if(typeof a=="string")return J.Dr.prototype
if(a==null)return a
if(Array.isArray(a))return J.p.prototype
if(typeof a!="object"){if(typeof a=="function")return J.c5.prototype
if(typeof a=="symbol")return J.Dw.prototype
if(typeof a=="bigint")return J.rQ.prototype
return a}if(a instanceof A.a)return a
return J.M3(a)},
c(a){if(typeof a=="number"){if(Math.floor(a)==a)return J.im.prototype
return J.kD.prototype}if(typeof a=="string")return J.Dr.prototype
if(a==null)return J.CD.prototype
if(typeof a=="boolean")return J.yE.prototype
if(Array.isArray(a))return J.p.prototype
if(typeof a!="object"){if(typeof a=="function")return J.c5.prototype
if(typeof a=="symbol")return J.Dw.prototype
if(typeof a=="bigint")return J.rQ.prototype
return a}if(a instanceof A.a)return a
return J.M3(a)},
w1(a){if(a==null)return a
if(Array.isArray(a))return J.p.prototype
if(typeof a!="object"){if(typeof a=="function")return J.c5.prototype
if(typeof a=="symbol")return J.Dw.prototype
if(typeof a=="bigint")return J.rQ.prototype
return a}if(a instanceof A.a)return a
return J.M3(a)},
CR(a){return J.c(a).gbx(a)},
GA(a,b){return J.w1(a).F(a,b)},
Hm(a){return J.U6(a).gB(a)},
IT(a){return J.w1(a).gkz(a)},
M1(a,b,c){return J.w1(a).E2(a,b,c)},
Nu(a){return J.c(a).gi(a)},
cf(a,b){if(a==null)return b==null
if(typeof a!="object")return b!=null&&a===b
return J.c(a).DN(a,b)},
n(a){return J.c(a)["["](a)},
vB:function vB(){},
yE:function yE(){},
CD:function CD(){},
MF:function MF(){},
u0:function u0(){},
iC:function iC(){},
kd:function kd(){},
c5:function c5(){},
rQ:function rQ(){},
Dw:function Dw(){},
p:function p(a){this.$ti=a},
B:function B(){},
Po:function Po(a){this.$ti=a},
D:function D(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
qI:function qI(){},
im:function im(){},
kD:function kD(){},
Dr:function Dr(){}},A={FK:function FK(){},
G(a){return new A.SH("Field '"+a+"' has been assigned during initialization.")},
la(a){return new A.SH("Field '"+a+"' has not been initialized.")},
oo(a){var s,r=a^48
if(r<=9)return r
s=a|32
if(97<=s&&s<=102)return s-87
return-1},
yc(a,b){a=a+b&536870911
a=a+((a&524287)<<10)&536870911
return a^a>>>6},
qL(a){a=a+((a&67108863)<<3)&536870911
a^=a>>>11
return a+((a&16383)<<15)&536870911},
ks(a){var s,r
for(s=$.Qu.length,r=0;r<s;++r)if(a===$.Qu[r])return!0
return!1},
K1(a,b,c,d){if(t.Q.b(a))return new A.xy(a,b,c.C("@<0>").Kq(d).C("xy<1,2>"))
return new A.i1(a,b,c.C("@<0>").Kq(d).C("i1<1,2>"))},
Wp(){return new A.lj("No element")},
SH:function SH(a){this.a=a},
zl:function zl(){},
bQ:function bQ(){},
aL:function aL(){},
a7:function a7(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
i1:function i1(a,b,c){this.a=a
this.b=b
this.$ti=c},
xy:function xy(a,b,c){this.a=a
this.b=b
this.$ti=c},
MH:function MH(a,b,c){var _=this
_.a=null
_.b=a
_.c=b
_.$ti=c},
A8:function A8(a,b,c){this.a=a
this.b=b
this.$ti=c},
SU:function SU(){},
H(a){var s=v.mangledGlobalNames[a]
if(s!=null)return s
return"minified:"+a},
wV(a,b){var s
if(b!=null){s=b.x
if(s!=null)return s}return t.p.b(a)},
I(a){var s
if(typeof a=="string")return a
if(typeof a=="number"){if(a!==0)return""+a}else if(!0===a)return"true"
else if(!1===a)return"false"
else if(a==null)return"null"
s=J.n(a)
return s},
eQ(a){var s,r=$.xu
if(r==null)r=$.xu=Symbol("identityHashCode")
s=a[r]
if(s==null){s=Math.random()*0x3fffffff|0
a[r]=s}return s},
Hp(a,b){var s,r,q,p,o,n=null,m=/^\s*[+-]?((0x[a-f0-9]+)|(\d+)|([a-z0-9]+))\s*$/i.exec(a)
if(m==null)return n
s=m[3]
if(b==null){if(s!=null)return parseInt(a,10)
if(m[2]!=null)return parseInt(a,16)
return n}if(b<2||b>36)throw A.L(A.TE(b,2,36,"radix",n))
if(b===10&&s!=null)return parseInt(a,10)
if(b<10||s==null){r=b<=10?47+b:86+b
q=m[1]
for(p=q.length,o=0;o<p;++o)if((q.charCodeAt(o)|32)>r)return n}return parseInt(a,b)},
l(a){var s,r,q,p
if(a instanceof A.a)return A.d(A.z(a),null)
s=J.c(a)
if(s===B.Ok||s===B.Ub||t.o.b(a)){r=B.O4(a)
if(r!=="Object"&&r!=="")return r
q=a.constructor
if(typeof q=="function"){p=q.name
if(typeof p=="string"&&p!=="Object"&&p!=="")return p}}return A.d(A.z(a),null)},
i(a){var s,r,q
if(a==null||typeof a=="number"||A.y(a))return J.n(a)
if(typeof a=="string")return JSON.stringify(a)
if(a instanceof A.t)return a["["](0)
if(a instanceof A.M)return a.k(!0)
s=$.u()
for(r=0;r<1;++r){q=s[r].R(a)
if(q!=null)return q}return"Instance of '"+A.l(a)+"'"},
fw(a,b,c){var s,r,q,p
if(c<=500&&b===0&&c===a.length)return String.fromCharCode.apply(null,a)
for(s=b,r="";s<c;s=q){q=s+500
p=q<c?q:c
r+=String.fromCharCode.apply(null,a.subarray(s,p))}return r},
Lw(a){var s
if(0<=a){if(a<=65535)return String.fromCharCode(a)
if(a<=1114111){s=a-65536
return String.fromCharCode((B.jn.P(s,10)|55296)>>>0,s&1023|56320)}}throw A.L(A.TE(a,0,1114111,null,null))},
au(a,b,c){if(a>c)return A.TE(a,0,c,"start",null)
if(b!=null)if(b<a||b>c)return A.TE(b,a,c,"end",null)
return new A.AT(!0,b,"end",null)},
tL(a){return new A.AT(!0,a,null,null)},
L(a){return A.r(a,new Error())},
r(a,b){var s
if(a==null)a=new A.E()
b.dartException=a
s=A.J
if("defineProperty" in Object){Object.defineProperty(b,"message",{get:s})
b.name=""}else b.toString=s
return b},
J(){return J.n(this.dartException)},
v(a,b){throw A.r(a,b==null?new Error():b)},
cW(a,b,c){var s
if(b==null)b=0
if(c==null)c=0
s=Error()
A.v(A.HK(a,b,c),s)},
HK(a,b,c){var s,r,q,p,o,n,m,l,k
if(typeof b=="string")s=b
else{r="[]=;add;removeWhere;retainWhere;removeRange;setRange;setInt8;setInt16;setInt32;setUint8;setUint16;setUint32;setFloat32;setFloat64".split(";")
q=r.length
p=b
if(p>q){c=p/q|0
p%=q}s=r[p]}o=typeof c=="string"?c:"modify;remove from;add to".split(";")[c]
n=t.j.b(a)?"list":"ByteData"
m=a.$flags|0
l="a "
if((m&4)!==0)k="constant "
else if((m&2)!==0){k="unmodifiable "
l="an "}else k=(m&1)!==0?"fixed-length ":""
return new A.ub("'"+s+"': Cannot "+o+" "+l+k+n)},
lk(a){throw A.L(A.a4(a))},
CU(a){if(a==null)return J.Nu(a)
if(typeof a=="object")return A.eQ(a)
return J.Nu(a)},
dJ(a,b){var s,r,q,p=a.length
for(s=0;s<p;s=q){r=s+1
q=r+1
b.t(0,a[s],a[r])}return b},
iA(a2){var s,r,q,p,o,n,m,l,k,j,i=a2.co,h=a2.iS,g=a2.iI,f=a2.nDA,e=a2.aI,d=a2.fs,c=a2.cs,b=d[0],a=c[0],a0=i[b],a1=a2.fT
a1.toString
s=h?Object.create(new A.zx().constructor.prototype):Object.create(new A.rT(null,null).constructor.prototype)
s.$initialize=s.constructor
r=h?function static_tear_off(){this.$initialize()}:function tear_off(a3,a4){this.$initialize(a3,a4)}
s.constructor=r
r.prototype=s
s.$_name=b
s.$_target=a0
q=!h
if(q)p=A.bx(b,a0,g,f)
else{s.$static_name=b
p=a0}s.$S=A.fm(a1,h,g)
s[a]=p
for(o=p,n=1;n<d.length;++n){m=d[n]
if(typeof m=="string"){l=i[m]
k=m
m=l}else k=""
j=c[n]
if(j!=null){if(q)m=A.bx(k,m,g,f)
s[j]=m}if(n===e)o=m}s.$C=o
s.$R=a2.rC
s.$D=a2.dV
return r},
fm(a,b,c){if(typeof a=="number")return a
if(typeof a=="string"){if(b)throw A.L("Cannot compute signature for static tearoff.")
return function(d,e){return function(){return e(this,d)}}(a,A.Tn)}throw A.L("Error in functionType of tearoff")},
vq(a,b,c,d){var s=A.yS
switch(b?-1:a){case 0:return function(e,f){return function(){return f(this)[e]()}}(c,s)
case 1:return function(e,f){return function(g){return f(this)[e](g)}}(c,s)
case 2:return function(e,f){return function(g,h){return f(this)[e](g,h)}}(c,s)
case 3:return function(e,f){return function(g,h,i){return f(this)[e](g,h,i)}}(c,s)
case 4:return function(e,f){return function(g,h,i,j){return f(this)[e](g,h,i,j)}}(c,s)
case 5:return function(e,f){return function(g,h,i,j,k){return f(this)[e](g,h,i,j,k)}}(c,s)
default:return function(e,f){return function(){return e.apply(f(this),arguments)}}(d,s)}},
bx(a,b,c,d){if(c)return A.Hf(a,b,d)
return A.vq(b.length,d,a,b)},
Z4(a,b,c,d){var s=A.yS,r=A.AO
switch(b?-1:a){case 0:throw A.L(new A.Eq("Intercepted function with no arguments."))
case 1:return function(e,f,g){return function(){return f(this)[e](g(this))}}(c,r,s)
case 2:return function(e,f,g){return function(h){return f(this)[e](g(this),h)}}(c,r,s)
case 3:return function(e,f,g){return function(h,i){return f(this)[e](g(this),h,i)}}(c,r,s)
case 4:return function(e,f,g){return function(h,i,j){return f(this)[e](g(this),h,i,j)}}(c,r,s)
case 5:return function(e,f,g){return function(h,i,j,k){return f(this)[e](g(this),h,i,j,k)}}(c,r,s)
case 6:return function(e,f,g){return function(h,i,j,k,l){return f(this)[e](g(this),h,i,j,k,l)}}(c,r,s)
default:return function(e,f,g){return function(){var q=[g(this)]
Array.prototype.push.apply(q,arguments)
return e.apply(f(this),q)}}(d,r,s)}},
Hf(a,b,c){var s,r
if($.Hb==null)$.Hb=A.L4("interceptor")
if($.i0==null)$.i0=A.L4("receiver")
s=b.length
r=A.Z4(s,c,a,b)
return r},
qm(a){return A.iA(a)},
Tn(a,b){return A.cE(v.typeUniverse,A.z(a.a),b)},
yS(a){return a.a},
AO(a){return a.b},
L4(a){var s,r,q,p=new A.rT("receiver","interceptor"),o=Object.getOwnPropertyNames(p)
o.$flags=1
s=o
for(o=s.length,r=0;r<o;++r){q=s[r]
if(p[q]===a)return q}throw A.L(A.q("Field name "+a+" not found."))},
Yg(a){return v.getIsolateTag(a)},
A(a){var s,r,q,p,o,n=$.NF.$1(a),m=$.nw[n]
if(m!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
return m.i}s=$.vv[n]
if(s!=null)return s
r=v.interceptorsByTag[n]
if(r==null){q=$.TX.$2(a,n)
if(q!=null){m=$.nw[q]
if(m!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
return m.i}s=$.vv[q]
if(s!=null)return s
r=v.interceptorsByTag[q]
n=q}}if(r==null)return null
s=r.prototype
p=n[0]
if(p==="!"){m=A.Va(s)
$.nw[n]=m
Object.defineProperty(a,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
return m.i}if(p==="~"){$.vv[n]=s
return s}if(p==="-"){o=A.Va(s)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:o,enumerable:false,writable:true,configurable:true})
return o.i}if(p==="+")return A.Lc(a,s)
if(p==="*")throw A.L(A.SY(n))
if(v.leafTags[n]===true){o=A.Va(s)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:o,enumerable:false,writable:true,configurable:true})
return o.i}else return A.Lc(a,s)},
Lc(a,b){var s=Object.getPrototypeOf(a)
Object.defineProperty(s,v.dispatchPropertyName,{value:J.uM(b,s,null,null),enumerable:false,writable:true,configurable:true})
return b},
Va(a){return J.uM(a,!1,null,!!a.$iXj)},
VF(a,b,c){var s=b.prototype
if(v.leafTags[a]===true)return A.Va(s)
else return J.uM(s,c,null,null)},
XD(){if(!0===$.Bv)return
$.Bv=!0
A.Z1()},
Z1(){var s,r,q,p,o,n,m,l
$.nw=Object.create(null)
$.vv=Object.create(null)
A.kO()
s=v.interceptorsByTag
r=Object.getOwnPropertyNames(s)
if(typeof window!="undefined"){window
q=function(){}
for(p=0;p<r.length;++p){o=r[p]
n=$.x7.$1(o)
if(n!=null){m=A.VF(o,s[o],n)
if(m!=null){Object.defineProperty(n,v.dispatchPropertyName,{value:m,enumerable:false,writable:true,configurable:true})
q.prototype=n}}}}for(p=0;p<r.length;++p){o=r[p]
if(/^[A-Za-z_]/.test(o)){l=s[o]
s["!"+o]=l
s["~"+o]=l
s["-"+o]=l
s["+"+o]=l
s["*"+o]=l}}},
kO(){var s,r,q,p,o,n,m=B.Yq()
m=A.ud(B.KU,A.ud(B.fQ,A.ud(B.i7,A.ud(B.i7,A.ud(B.xi,A.ud(B.dk,A.ud(B.wb(B.O4),m)))))))
if(typeof dartNativeDispatchHooksTransformer!="undefined"){s=dartNativeDispatchHooksTransformer
if(typeof s=="function")s=[s]
if(Array.isArray(s))for(r=0;r<s.length;++r){q=s[r]
if(typeof q=="function")m=q(m)||m}}p=m.getTag
o=m.getUnknownTag
n=m.prototypeForTag
$.NF=new A.dC(p)
$.TX=new A.wN(o)
$.x7=new A.VX(n)},
ud(a,b){return a(b)||b},
Wk(a,b){var s=b.length,r=v.rttc[""+s+";"+a]
if(r==null)return null
if(s===0)return r
if(s===r.length)return r.apply(null,b)
return r(b)},
v4(a,b,c,d,e,f){var s=b?"m":"",r=c?"":"i",q=d?"u":"",p=e?"s":"",o=function(g,h){try{return new RegExp(g,h)}catch(n){return n}}(a,s+r+q+p+f)
if(o instanceof RegExp)return o
throw A.L(A.rr("Illegal RegExp pattern ("+String(o)+")",a,null))},
m2(a,b,c){var s=a.indexOf(b,c)
return s>=0},
S0:function S0(a,b){this.a=a
this.b=b},
rY:function rY(){},
t:function t(){},
E1:function E1(){},
lc:function lc(){},
zx:function zx(){},
rT:function rT(a,b){this.a=a
this.b=b},
Eq:function Eq(a){this.a=a},
N5:function N5(a){var _=this
_.a=0
_.f=_.e=_.d=_.c=_.b=null
_.r=0
_.$ti=a},
vh:function vh(a,b){var _=this
_.a=a
_.b=b
_.d=_.c=null},
Gp:function Gp(a,b){this.a=a
this.$ti=b},
N6:function N6(a,b,c){var _=this
_.a=a
_.b=b
_.c=c
_.d=null},
dC:function dC(a){this.a=a},
wN:function wN(a){this.a=a},
VX:function VX(a){this.a=a},
M:function M(){},
B7:function B7(){},
VR:function VR(a,b){var _=this
_.a=a
_.b=b
_.e=_.d=_.c=null},
rM(a,b,c){var s
if(!(a>>>0!==a))s=b>>>0!==b||a>b||b>c
else s=!0
if(s)throw A.L(A.au(a,b,c))
return b},
WZ:function WZ(){},
eH:function eH(){},
df:function df(){},
b0:function b0(){},
Dg:function Dg(){},
DV:function DV(){},
zU:function zU(){},
K8:function K8(){},
xj:function xj(){},
dE:function dE(){},
Zc:function Zc(){},
wf:function wf(){},
Pq:function Pq(){},
eE:function eE(){},
V6:function V6(){},
RG:function RG(){},
vX:function vX(){},
WB:function WB(){},
VS:function VS(){},
xZ(a,b){var s=b.c
return s==null?b.c=A.Q2(a,"b8",[b.x]):s},
Q1(a){var s=a.w
if(s===6||s===7)return A.Q1(a.x)
return s===11||s===12},
mD(a){return a.as},
q7(a){return A.Ew(v.typeUniverse,a,!1)},
PL(a1,a2,a3,a4){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0=a2.w
switch(a0){case 5:case 1:case 2:case 3:case 4:return a2
case 6:s=a2.x
r=A.PL(a1,s,a3,a4)
if(r===s)return a2
return A.Bc(a1,r,!0)
case 7:s=a2.x
r=A.PL(a1,s,a3,a4)
if(r===s)return a2
return A.LN(a1,r,!0)
case 8:q=a2.y
p=A.bZ(a1,q,a3,a4)
if(p===q)return a2
return A.Q2(a1,a2.x,p)
case 9:o=a2.x
n=A.PL(a1,o,a3,a4)
m=a2.y
l=A.bZ(a1,m,a3,a4)
if(n===o&&l===m)return a2
return A.ap(a1,n,l)
case 10:k=a2.x
j=a2.y
i=A.bZ(a1,j,a3,a4)
if(i===j)return a2
return A.oP(a1,k,i)
case 11:h=a2.x
g=A.PL(a1,h,a3,a4)
f=a2.y
e=A.qT(a1,f,a3,a4)
if(g===h&&e===f)return a2
return A.Nf(a1,g,e)
case 12:d=a2.y
a4+=d.length
c=A.bZ(a1,d,a3,a4)
o=a2.x
n=A.PL(a1,o,a3,a4)
if(c===d&&n===o)return a2
return A.DS(a1,n,c,!0)
case 13:b=a2.x
if(b<a4)return a2
a=a3[b-a4]
if(a==null)return a2
return a
default:throw A.L(A.hV("Attempted to substitute unexpected RTI kind "+a0))}},
bZ(a,b,c,d){var s,r,q,p,o=b.length,n=A.vU(o)
for(s=!1,r=0;r<o;++r){q=b[r]
p=A.PL(a,q,c,d)
if(p!==q)s=!0
n[r]=p}return s?n:b},
vO(a,b,c,d){var s,r,q,p,o,n,m=b.length,l=A.vU(m)
for(s=!1,r=0;r<m;r+=3){q=b[r]
p=b[r+1]
o=b[r+2]
n=A.PL(a,o,c,d)
if(n!==o)s=!0
l.splice(r,3,q,p,n)}return s?l:b},
qT(a,b,c,d){var s,r=b.a,q=A.bZ(a,r,c,d),p=b.b,o=A.bZ(a,p,c,d),n=b.c,m=A.vO(a,n,c,d)
if(q===r&&o===p&&m===n)return b
s=new A.ET()
s.a=q
s.b=o
s.c=m
return s},
j(a,b){a[v.arrayRti]=b
return a},
JS(a){var s=a.$S
if(s!=null){if(typeof s=="number")return A.Bp(s)
return a.$S()}return null},
Ue(a,b){var s
if(A.Q1(b))if(a instanceof A.t){s=A.JS(a)
if(s!=null)return s}return A.z(a)},
z(a){if(a instanceof A.a)return A.Lh(a)
if(Array.isArray(a))return A.t6(a)
return A.VU(J.c(a))},
t6(a){var s=a[v.arrayRti],r=t.b
if(s==null)return r
if(s.constructor!==r.constructor)return r
return s},
Lh(a){var s=a.$ti
return s!=null?s:A.VU(a)},
VU(a){var s=a.constructor,r=s.$ccache
if(r!=null)return r
return A.r9(a,s)},
r9(a,b){var s=a instanceof A.t?Object.getPrototypeOf(Object.getPrototypeOf(a)).constructor:b,r=A.ai(v.typeUniverse,s.name)
b.$ccache=r
return r},
Bp(a){var s,r=v.types,q=r[a]
if(typeof q=="string"){s=A.Ew(v.typeUniverse,q,!1)
r[a]=s
return s}return q},
RW(a){return A.Kx(A.Lh(a))},
tu(a){var s
if(a instanceof A.M)return A.Mi(a.$r,a.n())
s=a instanceof A.t?A.JS(a):null
if(s!=null)return s
if(t.R.b(a))return J.CR(a).a
if(Array.isArray(a))return A.t6(a)
return A.z(a)},
Kx(a){var s=a.r
return s==null?a.r=new A.lY(a):s},
Mi(a,b){var s,r,q=b,p=q.length
if(p===0)return t.F
s=A.cE(v.typeUniverse,A.tu(q[0]),"@<0>")
for(r=1;r<p;++r)s=A.v5(v.typeUniverse,s,A.tu(q[r]))
return A.cE(v.typeUniverse,s,a)},
xq(a){return A.Kx(A.Ew(v.typeUniverse,a,!1))},
JJ(a){var s=this
s.b=A.fr(s)
return s.b(a)},
fr(a){var s,r,q,p
if(a===t.K)return A.ke
if(A.cc(a))return A.Iw
s=a.w
if(s===6)return A.AQ
if(s===1)return A.JY
if(s===7)return A.fg
r=A.U5(a)
if(r!=null)return r
if(s===8){q=a.x
if(a.y.every(A.cc)){a.f="$i"+q
if(q==="zM")return A.yM
if(a===t.m)return A.xD
return A.t4}}else if(s===10){p=A.Wk(a.x,a.y)
return p==null?A.JY:p}return A.YO},
U5(a){if(a.w===8){if(a===t.S)return A.ok
if(a===t.i||a===t.H)return A.KH
if(a===t.N)return A.MM
if(a===t.y)return A.y}return null},
Au(a){var s=this,r=A.Oz
if(A.cc(s))r=A.hn
else if(s===t.K)r=A.Ti
else if(A.lR(s)){r=A.l4
if(s===t.x)r=A.Uc
else if(s===t.w)r=A.ra
else if(s===t.u)r=A.M4
else if(s===t.n)r=A.cU
else if(s===t.I)r=A.Qk}else if(s===t.S)r=A.IZ
else if(s===t.N)r=A.Bt
else if(s===t.y)r=A.p8
else if(s===t.H)r=A.z5
else if(s===t.i)r=A.rV
s.a=r
return s.a(a)},
YO(a){var s=this
if(a==null)return A.lR(s)
return A.t1(v.typeUniverse,A.Ue(a,s),s)},
AQ(a){if(a==null)return!0
return this.x.b(a)},
t4(a){var s,r=this
if(a==null)return A.lR(r)
s=r.f
if(a instanceof A.a)return!!a[s]
return!!J.c(a)[s]},
yM(a){var s,r=this
if(a==null)return A.lR(r)
if(typeof a!="object")return!1
if(Array.isArray(a))return!0
s=r.f
if(a instanceof A.a)return!!a[s]
return!!J.c(a)[s]},
xD(a){var s=this
if(a==null)return!1
if(typeof a=="object"){if(a instanceof A.a)return!!a[s.f]
return!0}if(typeof a=="function")return!0
return!1},
Oz(a){var s=this
if(a==null){if(A.lR(s))return a}else if(s.b(a))return a
throw A.r(A.fT(a,s),new Error())},
l4(a){var s=this
if(a==null||s.b(a))return a
throw A.r(A.fT(a,s),new Error())},
fT(a,b){return new A.iM("TypeError: "+A.WK(a,A.d(b,null)))},
WK(a,b){return A.h(a)+": type '"+A.d(A.tu(a),null)+"' is not a subtype of type '"+b+"'"},
Lz(a,b){return new A.iM("TypeError: "+A.WK(a,b))},
fg(a){var s=this
return s.x.b(a)||A.xZ(v.typeUniverse,s).b(a)},
ke(a){return a!=null},
Ti(a){if(a!=null)return a
throw A.r(A.Lz(a,"Object"),new Error())},
Iw(a){return!0},
hn(a){return a},
JY(a){return!1},
y(a){return!0===a||!1===a},
p8(a){if(!0===a)return!0
if(!1===a)return!1
throw A.r(A.Lz(a,"bool"),new Error())},
M4(a){if(!0===a)return!0
if(!1===a)return!1
if(a==null)return a
throw A.r(A.Lz(a,"bool?"),new Error())},
rV(a){if(typeof a=="number")return a
throw A.r(A.Lz(a,"double"),new Error())},
Qk(a){if(typeof a=="number")return a
if(a==null)return a
throw A.r(A.Lz(a,"double?"),new Error())},
ok(a){return typeof a=="number"&&Math.floor(a)===a},
IZ(a){if(typeof a=="number"&&Math.floor(a)===a)return a
throw A.r(A.Lz(a,"int"),new Error())},
Uc(a){if(typeof a=="number"&&Math.floor(a)===a)return a
if(a==null)return a
throw A.r(A.Lz(a,"int?"),new Error())},
KH(a){return typeof a=="number"},
z5(a){if(typeof a=="number")return a
throw A.r(A.Lz(a,"num"),new Error())},
cU(a){if(typeof a=="number")return a
if(a==null)return a
throw A.r(A.Lz(a,"num?"),new Error())},
MM(a){return typeof a=="string"},
Bt(a){if(typeof a=="string")return a
throw A.r(A.Lz(a,"String"),new Error())},
ra(a){if(typeof a=="string")return a
if(a==null)return a
throw A.r(A.Lz(a,"String?"),new Error())},
m(a,b){var s,r,q
for(s="",r="",q=0;q<a.length;++q,r=", ")s+=r+A.d(a[q],b)
return s},
k(a,b){var s,r,q,p,o,n,m=a.x,l=a.y
if(""===m)return"("+A.m(l,b)+")"
s=l.length
r=m.split(",")
q=r.length-s
for(p="(",o="",n=0;n<s;++n,o=", "){p+=o
if(q===0)p+="{"
p+=A.d(l[n],b)
if(q>=0)p+=" "+r[q];++q}return p+"})"},
b(a1,a2,a3){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a=", ",a0=null
if(a3!=null){s=a3.length
if(a2==null)a2=A.j([],t.s)
else a0=a2.length
r=a2.length
for(q=s;q>0;--q)a2.push("T"+(r+q))
for(p=t.X,o="<",n="",q=0;q<s;++q,n=a){o=o+n+a2[a2.length-1-q]
m=a3[q]
l=m.w
if(!(l===2||l===3||l===4||l===5||m===p))o+=" extends "+A.d(m,a2)}o+=">"}else o=""
p=a1.x
k=a1.y
j=k.a
i=j.length
h=k.b
g=h.length
f=k.c
e=f.length
d=A.d(p,a2)
for(c="",b="",q=0;q<i;++q,b=a)c+=b+A.d(j[q],a2)
if(g>0){c+=b+"["
for(b="",q=0;q<g;++q,b=a)c+=b+A.d(h[q],a2)
c+="]"}if(e>0){c+=b+"{"
for(b="",q=0;q<e;q+=3,b=a){c+=b
if(f[q+1])c+="required "
c+=A.d(f[q+2],a2)+" "+f[q]}c+="}"}if(a0!=null){a2.toString
a2.length=a0}return o+"("+c+") => "+d},
d(a,b){var s,r,q,p,o,n,m=a.w
if(m===5)return"erased"
if(m===2)return"dynamic"
if(m===3)return"void"
if(m===1)return"Never"
if(m===4)return"any"
if(m===6){s=a.x
r=A.d(s,b)
q=s.w
return(q===11||q===12?"("+r+")":r)+"?"}if(m===7)return"FutureOr<"+A.d(a.x,b)+">"
if(m===8){p=A.o(a.x)
o=a.y
return o.length>0?p+("<"+A.m(o,b)+">"):p}if(m===10)return A.k(a,b)
if(m===11)return A.b(a,b,null)
if(m===12)return A.b(a.x,b,a.y)
if(m===13){n=a.x
return b[b.length-1-n]}return"?"},
o(a){var s=v.mangledGlobalNames[a]
if(s!=null)return s
return"minified:"+a},
Qo(a,b){var s=a.tR[b]
for(;typeof s=="string";)s=a.tR[s]
return s},
ai(a,b){var s,r,q,p,o,n=a.eT,m=n[b]
if(m==null)return A.Ew(a,b,!1)
else if(typeof m=="number"){s=m
r=A.mZ(a,5,"#")
q=A.vU(s)
for(p=0;p<s;++p)q[p]=r
o=A.Q2(a,b,q)
n[b]=o
return o}else return m},
xb(a,b){return A.Ix(a.tR,b)},
FF(a,b){return A.Ix(a.eT,b)},
Ew(a,b,c){var s,r=a.eC,q=r.get(b)
if(q!=null)return q
s=A.eT(A.ow(a,null,b,!1))
r.set(b,s)
return s},
cE(a,b,c){var s,r,q=b.z
if(q==null)q=b.z=new Map()
s=q.get(c)
if(s!=null)return s
r=A.eT(A.ow(a,b,c,!0))
q.set(c,r)
return r},
v5(a,b,c){var s,r,q,p=b.Q
if(p==null)p=b.Q=new Map()
s=c.as
r=p.get(s)
if(r!=null)return r
q=A.ap(a,b,c.w===9?c.y:[c])
p.set(s,q)
return q},
BD(a,b){b.a=A.Au
b.b=A.JJ
return b},
mZ(a,b,c){var s,r,q=a.eC.get(c)
if(q!=null)return q
s=new A.Jc(null,null)
s.w=b
s.as=c
r=A.BD(a,s)
a.eC.set(c,r)
return r},
Bc(a,b,c){var s,r=b.as+"?",q=a.eC.get(r)
if(q!=null)return q
s=A.ll(a,b,r,c)
a.eC.set(r,s)
return s},
ll(a,b,c,d){var s,r,q
if(d){s=b.w
r=!0
if(!A.cc(b))if(!(b===t.P||b===t.T))if(s!==6)r=s===7&&A.lR(b.x)
if(r)return b
else if(s===1)return t.P}q=new A.Jc(null,null)
q.w=6
q.x=b
q.as=c
return A.BD(a,q)},
LN(a,b,c){var s,r=b.as+"/",q=a.eC.get(r)
if(q!=null)return q
s=A.eV(a,b,r,c)
a.eC.set(r,s)
return s},
eV(a,b,c,d){var s,r
if(d){s=b.w
if(A.cc(b)||b===t.K)return b
else if(s===1)return A.Q2(a,"b8",[b])
else if(b===t.P||b===t.T)return t.W}r=new A.Jc(null,null)
r.w=7
r.x=b
r.as=c
return A.BD(a,r)},
Hc(a,b){var s,r,q=""+b+"^",p=a.eC.get(q)
if(p!=null)return p
s=new A.Jc(null,null)
s.w=13
s.x=b
s.as=q
r=A.BD(a,s)
a.eC.set(q,r)
return r},
Ux(a){var s,r,q,p=a.length
for(s="",r="",q=0;q<p;++q,r=",")s+=r+a[q].as
return s},
S4(a){var s,r,q,p,o,n=a.length
for(s="",r="",q=0;q<n;q+=3,r=","){p=a[q]
o=a[q+1]?"!":":"
s+=r+p+o+a[q+2].as}return s},
Q2(a,b,c){var s,r,q,p=b
if(c.length>0)p+="<"+A.Ux(c)+">"
s=a.eC.get(p)
if(s!=null)return s
r=new A.Jc(null,null)
r.w=8
r.x=b
r.y=c
if(c.length>0)r.c=c[0]
r.as=p
q=A.BD(a,r)
a.eC.set(p,q)
return q},
ap(a,b,c){var s,r,q,p,o,n
if(b.w===9){s=b.x
r=b.y.concat(c)}else{r=c
s=b}q=s.as+(";<"+A.Ux(r)+">")
p=a.eC.get(q)
if(p!=null)return p
o=new A.Jc(null,null)
o.w=9
o.x=s
o.y=r
o.as=q
n=A.BD(a,o)
a.eC.set(q,n)
return n},
oP(a,b,c){var s,r,q="+"+(b+"("+A.Ux(c)+")"),p=a.eC.get(q)
if(p!=null)return p
s=new A.Jc(null,null)
s.w=10
s.x=b
s.y=c
s.as=q
r=A.BD(a,s)
a.eC.set(q,r)
return r},
Nf(a,b,c){var s,r,q,p,o,n=b.as,m=c.a,l=m.length,k=c.b,j=k.length,i=c.c,h=i.length,g="("+A.Ux(m)
if(j>0){s=l>0?",":""
g+=s+"["+A.Ux(k)+"]"}if(h>0){s=l>0?",":""
g+=s+"{"+A.S4(i)+"}"}r=n+(g+")")
q=a.eC.get(r)
if(q!=null)return q
p=new A.Jc(null,null)
p.w=11
p.x=b
p.y=c
p.as=r
o=A.BD(a,p)
a.eC.set(r,o)
return o},
DS(a,b,c,d){var s,r=b.as+("<"+A.Ux(c)+">"),q=a.eC.get(r)
if(q!=null)return q
s=A.hw(a,b,c,r,d)
a.eC.set(r,s)
return s},
hw(a,b,c,d,e){var s,r,q,p,o,n,m,l
if(e){s=c.length
r=A.vU(s)
for(q=0,p=0;p<s;++p){o=c[p]
if(o.w===1){r[p]=o;++q}}if(q>0){n=A.PL(a,b,r,0)
m=A.bZ(a,c,r,0)
return A.DS(a,n,m,c!==m)}}l=new A.Jc(null,null)
l.w=12
l.x=b
l.y=c
l.as=d
return A.BD(a,l)},
ow(a,b,c,d){return{u:a,e:b,r:c,s:[],p:0,n:d}},
eT(a){var s,r,q,p,o,n,m,l=a.r,k=a.s
for(s=l.length,r=0;r<s;){q=l.charCodeAt(r)
if(q>=48&&q<=57)r=A.Al(r+1,q,l,k)
else if((((q|32)>>>0)-97&65535)<26||q===95||q===36||q===124)r=A.R8(a,r,l,k,!1)
else if(q===46)r=A.R8(a,r,l,k,!0)
else{++r
switch(q){case 44:break
case 58:k.push(!1)
break
case 33:k.push(!0)
break
case 59:k.push(A.KQ(a.u,a.e,k.pop()))
break
case 94:k.push(A.Hc(a.u,k.pop()))
break
case 35:k.push(A.mZ(a.u,5,"#"))
break
case 64:k.push(A.mZ(a.u,2,"@"))
break
case 126:k.push(A.mZ(a.u,3,"~"))
break
case 60:k.push(a.p)
a.p=k.length
break
case 62:A.rD(a,k)
break
case 38:A.I3(a,k)
break
case 63:p=a.u
k.push(A.Bc(p,A.KQ(p,a.e,k.pop()),a.n))
break
case 47:p=a.u
k.push(A.LN(p,A.KQ(p,a.e,k.pop()),a.n))
break
case 40:k.push(-3)
k.push(a.p)
a.p=k.length
break
case 41:A.Mt(a,k)
break
case 91:k.push(a.p)
a.p=k.length
break
case 93:o=k.splice(a.p)
A.cH(a.u,a.e,o)
a.p=k.pop()
k.push(o)
k.push(-1)
break
case 123:k.push(a.p)
a.p=k.length
break
case 125:o=k.splice(a.p)
A.Be(a.u,a.e,o)
a.p=k.pop()
k.push(o)
k.push(-2)
break
case 43:n=l.indexOf("(",r)
k.push(l.substring(r,n))
k.push(-4)
k.push(a.p)
a.p=k.length
r=n+1
break
default:throw"Bad character "+q}}}m=k.pop()
return A.KQ(a.u,a.e,m)},
Al(a,b,c,d){var s,r,q=b-48
for(s=c.length;a<s;++a){r=c.charCodeAt(a)
if(!(r>=48&&r<=57))break
q=q*10+(r-48)}d.push(q)
return a},
R8(a,b,c,d,e){var s,r,q,p,o,n,m=b+1
for(s=c.length;m<s;++m){r=c.charCodeAt(m)
if(r===46){if(e)break
e=!0}else{if(!((((r|32)>>>0)-97&65535)<26||r===95||r===36||r===124))q=r>=48&&r<=57
else q=!0
if(!q)break}}p=c.substring(b,m)
if(e){s=a.u
o=a.e
if(o.w===9)o=o.x
n=A.Qo(s,o.x)[p]
if(n==null)A.v('No "'+p+'" in "'+A.mD(o)+'"')
d.push(A.cE(s,o,n))}else d.push(p)
return m},
rD(a,b){var s,r=a.u,q=A.oU(a,b),p=b.pop()
if(typeof p=="string")b.push(A.Q2(r,p,q))
else{s=A.KQ(r,a.e,p)
switch(s.w){case 11:b.push(A.DS(r,s,q,a.n))
break
default:b.push(A.ap(r,s,q))
break}}},
Mt(a,b){var s,r,q,p=a.u,o=b.pop(),n=null,m=null
if(typeof o=="number")switch(o){case-1:n=b.pop()
break
case-2:m=b.pop()
break
default:b.push(o)
break}else b.push(o)
s=A.oU(a,b)
o=b.pop()
switch(o){case-3:o=b.pop()
if(n==null)n=p.sEA
if(m==null)m=p.sEA
r=A.KQ(p,a.e,o)
q=new A.ET()
q.a=s
q.b=n
q.c=m
b.push(A.Nf(p,r,q))
return
case-4:b.push(A.oP(p,b.pop(),s))
return
default:throw A.L(A.hV("Unexpected state under `()`: "+A.I(o)))}},
I3(a,b){var s=b.pop()
if(0===s){b.push(A.mZ(a.u,1,"0&"))
return}if(1===s){b.push(A.mZ(a.u,4,"1&"))
return}throw A.L(A.hV("Unexpected extended operation "+A.I(s)))},
oU(a,b){var s=b.splice(a.p)
A.cH(a.u,a.e,s)
a.p=b.pop()
return s},
KQ(a,b,c){if(typeof c=="string")return A.Q2(a,c,a.sEA)
else if(typeof c=="number"){b.toString
return A.TV(a,b,c)}else return c},
cH(a,b,c){var s,r=c.length
for(s=0;s<r;++s)c[s]=A.KQ(a,b,c[s])},
Be(a,b,c){var s,r=c.length
for(s=2;s<r;s+=3)c[s]=A.KQ(a,b,c[s])},
TV(a,b,c){var s,r,q=b.w
if(q===9){if(c===0)return b.x
s=b.y
r=s.length
if(c<=r)return s[c-1]
c-=r
b=b.x
q=b.w}else if(c===0)return b
if(q!==8)throw A.L(A.hV("Indexed base must be an interface type"))
s=b.y
if(c<=s.length)return s[c-1]
throw A.L(A.hV("Bad index "+c+" for "+b["["](0)))},
t1(a,b,c){var s,r=b.d
if(r==null)r=b.d=new Map()
s=r.get(c)
if(s==null){s=A.We(a,b,null,c,null)
r.set(c,s)}return s},
We(a,b,c,d,e){var s,r,q,p,o,n,m,l,k,j,i
if(b===d)return!0
if(A.cc(d))return!0
s=b.w
if(s===4)return!0
if(A.cc(b))return!1
if(b.w===1)return!0
r=s===13
if(r)if(A.We(a,c[b.x],c,d,e))return!0
q=d.w
p=t.P
if(b===p||b===t.T){if(q===7)return A.We(a,b,c,d.x,e)
return d===p||d===t.T||q===6}if(d===t.K){if(s===7)return A.We(a,b.x,c,d,e)
return s!==6}if(s===7){if(!A.We(a,b.x,c,d,e))return!1
return A.We(a,A.xZ(a,b),c,d,e)}if(s===6)return A.We(a,p,c,d,e)&&A.We(a,b.x,c,d,e)
if(q===7){if(A.We(a,b,c,d.x,e))return!0
return A.We(a,b,c,A.xZ(a,d),e)}if(q===6)return A.We(a,b,c,p,e)||A.We(a,b,c,d.x,e)
if(r)return!1
p=s!==11
if((!p||s===12)&&d===t.Z)return!0
o=s===10
if(o&&d===t.L)return!0
if(q===12){if(b===t.g)return!0
if(s!==12)return!1
n=b.y
m=d.y
l=n.length
if(l!==m.length)return!1
c=c==null?n:n.concat(c)
e=e==null?m:m.concat(e)
for(k=0;k<l;++k){j=n[k]
i=m[k]
if(!A.We(a,j,c,i,e)||!A.We(a,i,e,j,c))return!1}return A.bO(a,b.x,c,d.x,e)}if(q===11){if(b===t.g)return!0
if(p)return!1
return A.bO(a,b,c,d,e)}if(s===8){if(q!==8)return!1
return A.pG(a,b,c,d,e)}if(o&&q===10)return A.b6(a,b,c,d,e)
return!1},
bO(a3,a4,a5,a6,a7){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1,a2
if(!A.We(a3,a4.x,a5,a6.x,a7))return!1
s=a4.y
r=a6.y
q=s.a
p=r.a
o=q.length
n=p.length
if(o>n)return!1
m=n-o
l=s.b
k=r.b
j=l.length
i=k.length
if(o+j<n+i)return!1
for(h=0;h<o;++h){g=q[h]
if(!A.We(a3,p[h],a7,g,a5))return!1}for(h=0;h<m;++h){g=l[h]
if(!A.We(a3,p[o+h],a7,g,a5))return!1}for(h=0;h<i;++h){g=l[m+h]
if(!A.We(a3,k[h],a7,g,a5))return!1}f=s.c
e=r.c
d=f.length
c=e.length
for(b=0,a=0;a<c;a+=3){a0=e[a]
for(;!0;){if(b>=d)return!1
a1=f[b]
b+=3
if(a0<a1)return!1
a2=f[b-2]
if(a1<a0){if(a2)return!1
continue}g=e[a+1]
if(a2&&!g)return!1
g=f[b-1]
if(!A.We(a3,e[a+2],a7,g,a5))return!1
break}}for(;b<d;){if(f[b+1])return!1
b+=3}return!0},
pG(a,b,c,d,e){var s,r,q,p,o,n=b.x,m=d.x
for(;n!==m;){s=a.tR[n]
if(s==null)return!1
if(typeof s=="string"){n=s
continue}r=s[m]
if(r==null)return!1
q=r.length
p=q>0?new Array(q):v.typeUniverse.sEA
for(o=0;o<q;++o)p[o]=A.cE(a,b,r[o])
return A.SW(a,p,null,c,d.y,e)}return A.SW(a,b.y,null,c,d.y,e)},
SW(a,b,c,d,e,f){var s,r=b.length
for(s=0;s<r;++s)if(!A.We(a,b[s],d,e[s],f))return!1
return!0},
b6(a,b,c,d,e){var s,r=b.y,q=d.y,p=r.length
if(p!==q.length)return!1
if(b.x!==d.x)return!1
for(s=0;s<p;++s)if(!A.We(a,r[s],c,q[s],e))return!1
return!0},
lR(a){var s=a.w,r=!0
if(!(a===t.P||a===t.T))if(!A.cc(a))if(s!==6)r=s===7&&A.lR(a.x)
return r},
cc(a){var s=a.w
return s===2||s===3||s===4||s===5||a===t.X},
Ix(a,b){var s,r,q=Object.keys(b),p=q.length
for(s=0;s<p;++s){r=q[s]
a[r]=b[r]}},
vU(a){return a>0?new Array(a):v.typeUniverse.sEA},
Jc:function Jc(a,b){var _=this
_.a=a
_.b=b
_.r=_.f=_.d=_.c=null
_.w=0
_.as=_.Q=_.z=_.y=_.x=null},
ET:function ET(){this.c=this.b=this.a=null},
lY:function lY(a){this.a=a},
u9:function u9(){},
iM:function iM(a){this.a=a},
vL(a,b){var s=a[b]
return s===a?null:s},
a8(a,b,c){if(c==null)a[b]=a
else a[b]=c},
a0(){var s=Object.create(null)
A.a8(s,"<non-identifier-key>",s)
delete s["<non-identifier-key>"]
return s},
EF(a,b,c){return A.dJ(a,new A.N5(b.C("@<0>").Kq(c).C("N5<1,2>")))},
C(a,b){return new A.N5(a.C("@<0>").Kq(b).C("N5<1,2>"))},
nO(a){var s,r
if(A.ks(a))return"{...}"
s=new A.Rn("")
try{r={}
$.Qu.push(a)
s.a+="{"
r.a=!0
a.aN(0,new A.mN(r,s))
s.a+="}"}finally{$.Qu.pop()}r=s.a
return r.charCodeAt(0)==0?r:r},
k6:function k6(){},
YF:function YF(a){var _=this
_.a=0
_.e=_.d=_.c=_.b=null
_.$ti=a},
Ni:function Ni(a,b){this.a=a
this.$ti=b},
t3:function t3(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
F:function F(){},
il:function il(){},
mN:function mN(a,b){this.a=a
this.b=b},
Uk:function Uk(){},
wI:function wI(){},
Zi:function Zi(){},
u5:function u5(){},
E3:function E3(){},
Rw:function Rw(a){this.b=0
this.c=a},
QA(a,b){var s=A.Hp(a,b)
if(s!=null)return s
throw A.L(A.rr(a,null,null))},
O8(a,b,c){var s,r,q
if(a<0||a>4294967295)A.v(A.TE(a,0,4294967295,"length",null))
s=A.j(new Array(a),c.C("p<0>"))
s.$flags=1
r=s
if(a!==0&&b!=null)for(q=0;q<r.length;++q)r[q]=b
return r},
PW(a,b,c){var s,r,q=A.j([],c.C("p<0>"))
for(s=a.length,r=0;r<a.length;a.length===s||(0,A.lk)(a),++r)q.push(a[r])
q.$flags=1
return q},
HM(a){var s
A.k1(0,"start")
s=A.Nz(a,0,null)
return s},
Nz(a,b,c){var s=a.length
if(b>=s)return""
return A.fw(a,b,s)},
nu(a){return new A.VR(a,A.v4(a,!1,!0,!1,!1,""))},
vg(a,b,c){var s=J.IT(b)
if(!s.G())return a
if(c.length===0){do a+=A.I(s.gl())
while(s.G())}else{a+=A.I(s.gl())
for(;s.G();)a=a+c+A.I(s.gl())}return a},
eP(a,b,c,d){var s,r,q,p,o,n="0123456789ABCDEF"
if(c===B.xM){s=$.z4()
s=s.b.test(b)}else s=!1
if(s)return b
r=B.Qk.W(b)
for(s=r.length,q=0,p="";q<s;++q){o=r[q]
if(o<128&&(u.b.charCodeAt(o)&a)!==0)p+=A.Lw(o)
else p=d&&o===32?p+"+":p+"%"+n[o>>>4&15]+n[o&15]}return p.charCodeAt(0)==0?p:p},
tS(a){var s,r,q
if(!$.Ob())return A.yf(a)
s=new URLSearchParams()
a.aN(0,new A.bp(s))
r=s.toString()
q=r.length
if(q>0&&r[q-1]==="=")r=B.xB.Nj(r,0,q-1)
return r.replace(/=&|\*|%7E/g,b=>b==="=&"?"&":b==="*"?"%2A":"~")},
h(a){if(typeof a=="number"||A.y(a)||a==null)return J.n(a)
if(typeof a=="string")return JSON.stringify(a)
return A.i(a)},
hV(a){return new A.C6(a)},
q(a){return new A.AT(!1,null,null,a)},
TE(a,b,c,d,e){return new A.bJ(b,c,!0,a,d,"Invalid value")},
jB(a,b,c){if(0>a||a>c)throw A.L(A.TE(a,0,c,"start",null))
if(b!=null){if(a>b||b>c)throw A.L(A.TE(b,a,c,"end",null))
return b}return c},
k1(a,b){if(a<0)throw A.L(A.TE(a,0,null,b,null))
return a},
xF(a,b,c,d){return new A.eY(b,!0,a,d,"Index out of range")},
SY(a){return new A.ds(a)},
a4(a){return new A.UV(a)},
rr(a,b,c){return new A.aE(a,b,c)},
Sd(a,b,c){var s,r
if(A.ks(a)){if(b==="("&&c===")")return"(...)"
return b+"..."+c}s=A.j([],t.s)
$.Qu.push(a)
try{A.Vr(a,s)}finally{$.Qu.pop()}r=A.vg(b,s,", ")+c
return r.charCodeAt(0)==0?r:r},
x(a,b,c){var s,r
if(A.ks(a))return b+"..."+c
s=new A.Rn(b)
$.Qu.push(a)
try{r=s
r.a=A.vg(r.a,a,", ")}finally{$.Qu.pop()}s.a+=c
r=s.a
return r.charCodeAt(0)==0?r:r},
Vr(a,b){var s,r,q,p,o,n,m,l=a.gkz(a),k=0,j=0
while(!0){if(!(k<80||j<3))break
if(!l.G())return
s=A.I(l.gl())
b.push(s)
k+=s.length+2;++j}if(!l.G()){if(j<=5)return
r=b.pop()
q=b.pop()}else{p=l.gl();++j
if(!l.G()){if(j<=4){b.push(A.I(p))
return}r=A.I(p)
q=b.pop()
k+=r.length+2}else{o=l.gl();++j
for(;l.G();p=o,o=n){n=l.gl();++j
if(j>100){while(!0){if(!(k>75&&j>3))break
k-=b.pop().length+2;--j}b.push("...")
return}}q=A.I(p)
r=A.I(o)
k+=r.length+q.length+4}}if(j>b.length+2){k+=5
m="..."}else m=null
while(!0){if(!(k>80&&b.length>3))break
k-=b.pop().length+2
if(m==null){k+=5
m="..."}}if(m!=null)b.push(m)
b.push(q)
b.push(r)},
f5(a,b,c,d){var s
if(B.zt===c){s=B.jn.gi(a)
b=J.Nu(b)
return A.qL(A.yc(A.yc($.t8(),s),b))}if(B.zt===d){s=B.jn.gi(a)
b=J.Nu(b)
c=J.Nu(c)
return A.qL(A.yc(A.yc(A.yc($.t8(),s),b),c))}s=B.jn.gi(a)
b=J.Nu(b)
c=J.Nu(c)
d=J.Nu(d)
d=A.qL(A.yc(A.yc(A.yc(A.yc($.t8(),s),b),c),d))
return d},
Hh(a,b,c){var s,r,q,p,o,n,m="IPv4 address should contain exactly 4 parts",l="each part must be in the range 0..255",k=new A.cS(a),j=new Uint8Array(4)
for(s=b,r=s,q=0;s<c;++s){p=a.charCodeAt(s)
if(p!==46){if((p^48)>9)k.$2("invalid character",s)}else{if(q===3)k.$2(m,s)
o=A.QA(B.xB.Nj(a,r,s),null)
if(o>255)k.$2(l,r)
n=q+1
j[q]=o
r=s+1
q=n}}if(q!==3)k.$2(m,c)
o=A.QA(B.xB.Nj(a,r,c),null)
if(o>255)k.$2(l,r)
j[q]=o
return j},
Xh(a,b,c){var s
if(b===c)throw A.L(A.rr("Empty IP address",a,b))
if(a.charCodeAt(b)===118){s=A.lN(a,b,c)
if(s!=null)throw A.L(s)
return!1}A.eg(a,b,c)
return!0},
lN(a,b,c){var s,r,q,p,o="Missing hex-digit in IPvFuture address";++b
for(s=b;!0;s=r){if(s<c){r=s+1
q=a.charCodeAt(s)
if((q^48)<=9)continue
p=q|32
if(p>=97&&p<=102)continue
if(q===46){if(r-1===b)return new A.aE(o,a,r)
s=r
break}return new A.aE("Unexpected character",a,r-1)}if(s-1===b)return new A.aE(o,a,s)
return new A.aE("Missing '.' in IPvFuture address",a,s)}if(s===c)return new A.aE("Missing address in IPvFuture address, host, cursor",null,null)
for(;!0;){if((u.b.charCodeAt(a.charCodeAt(s))&16)!==0){++s
if(s<c)continue
return null}return new A.aE("Invalid IPvFuture address character",a,s)}},
eg(a,b,a0){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e=null,d=new A.VC(a),c=new A.JT(d,a)
if(a.length<2)d.$2("address is too short",e)
s=A.j([],t.t)
for(r=b,q=r,p=!1,o=!1;r<a0;++r){n=a.charCodeAt(r)
if(n===58){if(r===b){++r
if(a.charCodeAt(r)!==58)d.$2("invalid start colon.",r)
q=r}if(r===q){if(p)d.$2("only one wildcard `::` is allowed",r)
s.push(-1)
p=!0}else s.push(c.$2(q,r))
q=r+1}else if(n===46)o=!0}if(s.length===0)d.$2("too few parts",e)
m=q===a0
l=B.Nm.gV(s)
if(m&&l!==-1)d.$2("expected a part after last `:`",a0)
if(!m)if(!o)s.push(c.$2(q,a0))
else{k=A.Hh(a,q,a0)
s.push((k[0]<<8|k[1])>>>0)
s.push((k[2]<<8|k[3])>>>0)}if(p){if(s.length>7)d.$2("an address with a wildcard must have less than 7 parts",e)}else if(s.length!==8)d.$2("an address without a wildcard must contain exactly 8 parts",e)
j=new Uint8Array(16)
for(l=s.length,i=9-l,r=0,h=0;r<l;++r){g=s[r]
if(g===-1)for(f=0;f<i;++f){j[h]=0
j[h+1]=0
h+=2}else{j[h]=B.jn.P(g,8)
j[h+1]=g&255
h+=2}}return j},
wK(a){if(a==="http")return 80
if(a==="https")return 443
return 0},
R3(a,b,c){throw A.L(A.rr(c,a,b))},
Xd(a,a0,a1,a2){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e=null,d=a0.length,c="",b=e
if(d!==0){r=0
while(!0){if(!(r<d)){s=0
break}if(a0.charCodeAt(r)===64){c=B.xB.Nj(a0,0,r)
s=r+1
break}++r}if(s<d&&a0.charCodeAt(s)===91){for(q=s,p=-1;q<d;++q){o=a0.charCodeAt(q)
if(o===37&&p<0){n=B.xB.Y(a0,"25",q+1)?q+2:q
p=q
q=n}else if(o===93)break}if(q===d)throw A.L(A.rr("Invalid IPv6 host entry.",a0,s))
m=p<0?q:p
A.Xh(a0,s+1,m);++q
if(q!==d&&a0.charCodeAt(q)!==58)throw A.L(A.rr("Invalid end of authority",a0,q))}else q=s
for(;q<d;++q)if(a0.charCodeAt(q)===58){l=B.xB.yn(a0,q+1)
b=l.length!==0?A.QA(l,e):e
break}k=B.xB.Nj(a0,s,q)}else k=e
d=A.j(a1.split("/"),t.s)
a=A.Pi(a,0,a.length)
c=A.zR(c,0,c.length)
k=A.Oe(k,0,k==null?0:k.length,!1)
j=A.le(e,0,0,a2)
i=A.tG(e,0,0)
b=A.wB(b,a)
h=a==="file"
if(k==null)m=c.length!==0||b!=null||h
else m=!1
if(m)k=""
m=k==null
g=!m
f=A.ka(e,0,0,d,a,g)
d=a.length===0
if(d&&m&&!B.xB.v(f,"/"))f=A.wF(f,!d||g)
else f=A.xe(f)
return new A.Dn(a,c,m&&B.xB.v(f,"//")?"":k,b,f,j,i)},
wB(a,b){if(a!=null&&a===A.wK(b))return null
return a},
Oe(a,b,c,d){var s,r,q,p,o,n,m,l
if(a==null)return null
if(b===c)return""
if(a.charCodeAt(b)===91){s=c-1
if(a.charCodeAt(s)!==93)A.R3(a,b,"Missing end `]` to match `[` in host")
r=b+1
q=""
if(a.charCodeAt(r)!==118){p=A.to(a,r,s)
if(p<s){o=p+1
q=A.OA(a,B.xB.Y(a,"25",o)?p+3:o,s,"%25")}s=p}n=A.Xh(a,r,s)
m=B.xB.Nj(a,r,s)
return"["+(n?m.toLowerCase():m)+q+"]"}for(l=b;l<c;++l)if(a.charCodeAt(l)===58){s=B.xB.K(a,"%",b)
s=s>=b&&s<c?s:c
if(s<c){o=s+1
q=A.OA(a,B.xB.Y(a,"25",o)?s+3:o,c,"%25")}else q=""
A.eg(a,b,s)
return"["+B.xB.Nj(a,b,s)+q+"]"}return A.OL(a,b,c)},
to(a,b,c){var s=B.xB.K(a,"%",b)
return s>=b&&s<c?s:c},
OA(a,b,c,d){var s,r,q,p,o,n,m,l,k,j,i=d!==""?new A.Rn(d):null
for(s=b,r=s,q=!0;s<c;){p=a.charCodeAt(s)
if(p===37){o=A.rv(a,s,!0)
n=o==null
if(n&&q){s+=3
continue}if(i==null)i=new A.Rn("")
m=i.a+=B.xB.Nj(a,r,s)
if(n)o=B.xB.Nj(a,s,s+3)
else if(o==="%")A.R3(a,s,"ZoneID should not contain % anymore")
i.a=m+o
s+=3
r=s
q=!0}else if(p<127&&(u.b.charCodeAt(p)&1)!==0){if(q&&65<=p&&90>=p){if(i==null)i=new A.Rn("")
if(r<s){i.a+=B.xB.Nj(a,r,s)
r=s}q=!1}++s}else{l=1
if((p&64512)===55296&&s+1<c){k=a.charCodeAt(s+1)
if((k&64512)===56320){p=65536+((p&1023)<<10)+(k&1023)
l=2}}j=B.xB.Nj(a,r,s)
if(i==null){i=new A.Rn("")
n=i}else n=i
n.a+=j
m=A.zX(p)
n.a+=m
s+=l
r=s}}if(i==null)return B.xB.Nj(a,b,c)
if(r<c){j=B.xB.Nj(a,r,c)
i.a+=j}n=i.a
return n.charCodeAt(0)==0?n:n},
OL(a,b,c){var s,r,q,p,o,n,m,l,k,j,i,h=u.b
for(s=b,r=s,q=null,p=!0;s<c;){o=a.charCodeAt(s)
if(o===37){n=A.rv(a,s,!0)
m=n==null
if(m&&p){s+=3
continue}if(q==null)q=new A.Rn("")
l=B.xB.Nj(a,r,s)
if(!p)l=l.toLowerCase()
k=q.a+=l
j=3
if(m)n=B.xB.Nj(a,s,s+3)
else if(n==="%"){n="%25"
j=1}q.a=k+n
s+=j
r=s
p=!0}else if(o<127&&(h.charCodeAt(o)&32)!==0){if(p&&65<=o&&90>=o){if(q==null)q=new A.Rn("")
if(r<s){q.a+=B.xB.Nj(a,r,s)
r=s}p=!1}++s}else if(o<=93&&(h.charCodeAt(o)&1024)!==0)A.R3(a,s,"Invalid character")
else{j=1
if((o&64512)===55296&&s+1<c){i=a.charCodeAt(s+1)
if((i&64512)===56320){o=65536+((o&1023)<<10)+(i&1023)
j=2}}l=B.xB.Nj(a,r,s)
if(!p)l=l.toLowerCase()
if(q==null){q=new A.Rn("")
m=q}else m=q
m.a+=l
k=A.zX(o)
m.a+=k
s+=j
r=s}}if(q==null)return B.xB.Nj(a,b,c)
if(r<c){l=B.xB.Nj(a,r,c)
if(!p)l=l.toLowerCase()
q.a+=l}m=q.a
return m.charCodeAt(0)==0?m:m},
Pi(a,b,c){var s,r,q
if(b===c)return""
if(!A.Et(a.charCodeAt(b)))A.R3(a,b,"Scheme not starting with alphabetic character")
for(s=b,r=!1;s<c;++s){q=a.charCodeAt(s)
if(!(q<128&&(u.b.charCodeAt(q)&8)!==0))A.R3(a,s,"Illegal scheme character")
if(65<=q&&q<=90)r=!0}a=B.xB.Nj(a,b,c)
return A.Ya(r?a.toLowerCase():a)},
Ya(a){if(a==="http")return"http"
if(a==="file")return"file"
if(a==="https")return"https"
if(a==="package")return"package"
return a},
zR(a,b,c){return A.PI(a,b,c,16,!1,!1)},
ka(a,b,c,d,e,f){var s=e==="file",r=s||f,q=new A.A8(d,new A.RZ(),A.t6(d).C("A8<1,qU>")).h(0,"/")
if(q.length===0){if(s)return"/"}else if(r&&!B.xB.v(q,"/"))q="/"+q
return A.Jr(q,e,f)},
Jr(a,b,c){var s=b.length===0
if(s&&!c&&!B.xB.v(a,"/")&&!B.xB.v(a,"\\"))return A.wF(a,!s||c)
return A.xe(a)},
le(a,b,c,d){return A.tS(d)},
yf(a){var s={},r=new A.Rn("")
s.a=""
a.aN(0,new A.fq(new A.IP(s,r)))
s=r.a
return s.charCodeAt(0)==0?s:s},
tG(a,b,c){return null},
rv(a,b,c){var s,r,q,p,o,n=b+2
if(n>=a.length)return"%"
s=a.charCodeAt(b+1)
r=a.charCodeAt(n)
q=A.oo(s)
p=A.oo(r)
if(q<0||p<0)return"%"
o=q*16+p
if(o<127&&(u.b.charCodeAt(o)&1)!==0)return A.Lw(c&&65<=o&&90>=o?(o|32)>>>0:o)
if(s>=97||r>=97)return B.xB.Nj(a,b,b+3).toUpperCase()
return null},
zX(a){var s,r,q,p,o,n="0123456789ABCDEF"
if(a<=127){s=new Uint8Array(3)
s[0]=37
s[1]=n.charCodeAt(a>>>4)
s[2]=n.charCodeAt(a&15)}else{if(a>2047)if(a>65535){r=240
q=4}else{r=224
q=3}else{r=192
q=2}s=new Uint8Array(3*q)
for(p=0;--q,q>=0;r=128){o=B.jn.bf(a,6*q)&63|r
s[p]=37
s[p+1]=n.charCodeAt(o>>>4)
s[p+2]=n.charCodeAt(o&15)
p+=3}}return A.HM(s)},
PI(a,b,c,d,e,f){var s=A.Ul(a,b,c,d,e,f)
return s==null?B.xB.Nj(a,b,c):s},
Ul(a,b,c,d,e,f){var s,r,q,p,o,n,m,l,k,j=null,i=u.b
for(s=!e,r=b,q=r,p=j;r<c;){o=a.charCodeAt(r)
if(o<127&&(i.charCodeAt(o)&d)!==0)++r
else{n=1
if(o===37){m=A.rv(a,r,!1)
if(m==null){r+=3
continue}if("%"===m)m="%25"
else n=3}else if(o===92&&f)m="/"
else if(s&&o<=93&&(i.charCodeAt(o)&1024)!==0){A.R3(a,r,"Invalid character")
n=j
m=n}else{if((o&64512)===55296){l=r+1
if(l<c){k=a.charCodeAt(l)
if((k&64512)===56320){o=65536+((o&1023)<<10)+(k&1023)
n=2}}}m=A.zX(o)}if(p==null){p=new A.Rn("")
l=p}else l=p
l.a=(l.a+=B.xB.Nj(a,q,r))+m
r+=n
q=r}}if(p==null)return j
if(q<c){s=B.xB.Nj(a,q,c)
p.a+=s}s=p.a
return s.charCodeAt(0)==0?s:s},
yB(a){if(B.xB.v(a,"."))return!0
return B.xB.M(a,"/.")!==-1},
xe(a){var s,r,q,p,o,n
if(!A.yB(a))return a
s=A.j([],t.s)
for(r=a.split("/"),q=r.length,p=!1,o=0;o<q;++o){n=r[o]
if(n===".."){if(s.length!==0){s.pop()
if(s.length===0)s.push("")}p=!0}else{p="."===n
if(!p)s.push(n)}}if(p)s.push("")
return B.Nm.h(s,"/")},
wF(a,b){var s,r,q,p,o,n
if(!A.yB(a))return!b?A.C1(a):a
s=A.j([],t.s)
for(r=a.split("/"),q=r.length,p=!1,o=0;o<q;++o){n=r[o]
if(".."===n){p=s.length!==0&&B.Nm.gV(s)!==".."
if(p)s.pop()
else s.push("..")}else{p="."===n
if(!p)s.push(n)}}r=s.length
if(r!==0)r=r===1&&s[0].length===0
else r=!0
if(r)return"./"
if(p||B.Nm.gV(s)==="..")s.push("")
if(!b)s[0]=A.C1(s[0])
return B.Nm.h(s,"/")},
C1(a){var s,r,q=a.length
if(q>=2&&A.Et(a.charCodeAt(0)))for(s=1;s<q;++s){r=a.charCodeAt(s)
if(r===58)return B.xB.Nj(a,0,s)+"%3A"+B.xB.yn(a,s+1)
if(r>127||(u.b.charCodeAt(r)&8)===0)break}return a},
Et(a){var s=a|32
return 97<=s&&s<=122},
bp:function bp(a){this.a=a},
Ge:function Ge(){},
C6:function C6(a){this.a=a},
E:function E(){},
AT:function AT(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
bJ:function bJ(a,b,c,d,e,f){var _=this
_.e=a
_.f=b
_.a=c
_.b=d
_.c=e
_.d=f},
eY:function eY(a,b,c,d,e){var _=this
_.f=a
_.a=b
_.b=c
_.c=d
_.d=e},
ub:function ub(a){this.a=a},
ds:function ds(a){this.a=a},
lj:function lj(a){this.a=a},
UV:function UV(a){this.a=a},
k5:function k5(){},
aE:function aE(a,b,c){this.a=a
this.b=b
this.c=c},
cX:function cX(){},
c8:function c8(){},
a:function a(){},
Rn:function Rn(a){this.a=a},
cS:function cS(a){this.a=a},
VC:function VC(a){this.a=a},
JT:function JT(a,b){this.a=a
this.b=b},
Dn:function Dn(a,b,c,d,e,f,g){var _=this
_.a=a
_.b=b
_.c=c
_.d=d
_.e=e
_.f=f
_.r=g
_.y=_.w=$},
RZ:function RZ(){},
IP:function IP(a,b){this.a=a
this.b=b},
fq:function fq(a){this.a=a},
K(a,b,c){if(c>=1)return a.$1(b)
return a.$0()},
m6(a){return a==null||A.y(a)||typeof a=="number"||typeof a=="string"||t.U.b(a)||t.E.b(a)||t.e.b(a)||t.O.b(a)||t.D.b(a)||t.k.b(a)||t.v.b(a)||t.B.b(a)||t.q.b(a)||t.J.b(a)||t.Y.b(a)},
Pe(a){if(A.m6(a))return a
return new A.Pb(new A.YF(t.A)).$1(a)},
Pb:function Pb(a){this.a=a},
lM:function lM(){this.a=$},
YE:function YE(){},
hy(a){if(a==null)return null
return new A.TZ(a)},
TZ:function TZ(a){this.a=a},
E2(){var s,r,q,p,o=v.G,n=o.document.querySelectorAll("pre > code[data-dartpad]:only-child"),m=t.N,l=A.C(m,m)
o=o.window
m=new A.e(l)
if(typeof m=="function")A.v(A.q("Attempting to rewrap a JS function."))
s=function(a,b){return function(c){return a(b,c,arguments.length)}}(A.K,m)
s[$.w()]=m
o.addEventListener("message",s)
for(o=t.m,r=0;r<n.length;++r){q=n.item(r)
p=A.f(q==null?o.a(q):q)
if(p!=null)l.t(0,p.b,p.a)}},
f(a){var s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d=null,c="true",b=a.parentElement
if(b==null)return d
s=a.getAttribute("data-url")
$label0$0:{if(s!=null){r=s.length!==0
q=s}else{q=d
r=!1}if(r){r=q
break $label0$0}r="dartpad.dev"
break $label0$0}p=A.C(t.N,t.z)
if(!J.cf(a.getAttribute("data-embed"),"false"))p.t(0,"embed",c)
if(J.cf(a.getAttribute("data-theme"),"light"))p.t(0,"theme","light")
if(J.cf(a.getAttribute("data-run"),c))p.t(0,"run",c)
o=A.Xd("https",r,"",p).gL()
r=v.G
n=r.document.createElement("div")
m=r.document.createElement("iframe")
m.setAttribute("src",o)
l=a.getAttribute("title")
if(l!=null){r=l.length!==0
k=l}else{k=d
r=!1}if(r)m.setAttribute("title",k)
m.classList.add("embedded-dartpad")
r=$.j1
$.j1=r+1
j="embedded-dartpad-"+r
m.id=j
m.name=j
i=a.getAttribute("data-width")
if(i!=null){r=i.length!==0
h=i}else{h=d
r=!1}if(r)m.style.width=h
g=a.getAttribute("data-height")
if(g!=null){r=g.length!==0
f=g}else{f=d
r=!1}if(r)m.style.height=f
e=$.Ww().W(B.xB.OF(J.n(a.innerHTML)))
n.appendChild(m)
b.replaceWith(n)
if(m.contentWindow==null)return d
return new A.S0(e,j)},
e:function e(a){this.a=a},
pR(a){throw A.r(A.G(a),new Error())},
Q4(){throw A.r(A.la(""),new Error())},
kL(){throw A.r(A.G(""),new Error())}},B={}
var w=[A,J,B]
var $={}
A.FK.prototype={}
J.vB.prototype={
DN(a,b){return a===b},
gi(a){return A.eQ(a)},
"["(a){return"Instance of '"+A.l(a)+"'"},
gbx(a){return A.Kx(A.VU(this))}}
J.yE.prototype={
"["(a){return String(a)},
gi(a){return a?519018:218159},
gbx(a){return A.Kx(t.y)},
$iy5:1}
J.CD.prototype={
DN(a,b){return null==b},
"["(a){return"null"},
gi(a){return 0},
$iy5:1}
J.MF.prototype={$ivm:1}
J.u0.prototype={
gi(a){return 0},
"["(a){return String(a)}}
J.iC.prototype={}
J.kd.prototype={}
J.c5.prototype={
"["(a){var s=a[$.w()]
if(s==null)return this.u(a)
return"JavaScript function for "+J.n(s)}}
J.rQ.prototype={
gi(a){return 0},
"["(a){return String(a)}}
J.Dw.prototype={
gi(a){return 0},
"["(a){return String(a)}}
J.p.prototype={
FV(a,b){var s
a.$flags&1&&A.cW(a,"addAll",2)
for(s=b.gkz(b);s.G();)a.push(s.gl())},
E2(a,b,c){return new A.A8(a,b,A.t6(a).C("@<1>").Kq(c).C("A8<1,2>"))},
h(a,b){var s,r=A.O8(a.length,"",t.N)
for(s=0;s<a.length;++s)r[s]=A.I(a[s])
return r.join(b)},
F(a,b){return a[b]},
gV(a){var s=a.length
if(s>0)return a[s-1]
throw A.L(A.Wp())},
"["(a){return A.x(a,"[","]")},
gkz(a){return new J.D(a,a.length,A.t6(a).C("D<1>"))},
gi(a){return A.eQ(a)},
gB(a){return a.length},
$ibQ:1,
$icX:1,
$izM:1}
J.B.prototype={
R(a){var s,r,q
if(!Array.isArray(a))return null
s=a.$flags|0
if((s&4)!==0)r="const, "
else if((s&2)!==0)r="unmodifiable, "
else r=(s&1)!==0?"fixed, ":""
q="Instance of '"+A.l(a)+"'"
if(r==="")return q
return q+" ("+r+"length: "+a.length+")"}}
J.Po.prototype={}
J.D.prototype={
gl(){var s=this.d
return s==null?this.$ti.c.a(s):s},
G(){var s,r=this,q=r.a,p=q.length
if(r.b!==p)throw A.L(A.lk(q))
s=r.c
if(s>=p){r.d=null
return!1}r.d=q[s]
r.c=s+1
return!0}}
J.qI.prototype={
"["(a){if(a===0&&1/a<0)return"-0.0"
else return""+a},
gi(a){var s,r,q,p,o=a|0
if(a===o)return o&536870911
s=Math.abs(a)
r=Math.log(s)/0.6931471805599453|0
q=Math.pow(2,r)
p=s<1?s/q:q/s
return((p*9007199254740992|0)+(p*3542243181176521|0))*599197+r*1259&536870911},
P(a,b){var s
if(a>0)s=this.p(a,b)
else{s=b>31?31:b
s=a>>s>>>0}return s},
bf(a,b){if(0>b)throw A.L(A.tL(b))
return this.p(a,b)},
p(a,b){return b>31?0:a>>>b},
gbx(a){return A.Kx(t.H)},
$iCP:1}
J.im.prototype={
gbx(a){return A.Kx(t.S)},
$iy5:1,
$iKN:1}
J.kD.prototype={
gbx(a){return A.Kx(t.i)},
$iy5:1}
J.Dr.prototype={
Y(a,b,c){var s
if(c<0||c>a.length)throw A.L(A.TE(c,0,a.length,null,null))
s=c+b.length
if(s>a.length)return!1
return b===a.substring(c,s)},
v(a,b){return this.Y(a,b,0)},
Nj(a,b,c){return a.substring(b,A.jB(b,c,a.length))},
yn(a,b){return this.Nj(a,b,null)},
OF(a){var s,r=a.trimEnd(),q=r.length
if(q===0)return r
s=q-1
if(r.charCodeAt(s)!==133)return r
return r.substring(0,J.c1(r,s))},
Ix(a,b){var s,r
if(0>=b)return""
if(b===1||a.length===0)return a
if(b!==b>>>0)throw A.L(B.Eq)
for(s=a,r="";!0;){if((b&1)===1)r=s+r
b=b>>>1
if(b===0)break
s+=s}return r},
K(a,b,c){var s
if(c<0||c>a.length)throw A.L(A.TE(c,0,a.length,null,null))
s=a.indexOf(b,c)
return s},
M(a,b){return this.K(a,b,0)},
I(a,b){return A.m2(a,b,0)},
"["(a){return a},
gi(a){var s,r,q
for(s=a.length,r=0,q=0;q<s;++q){r=r+a.charCodeAt(q)&536870911
r=r+((r&524287)<<10)&536870911
r^=r>>6}r=r+((r&67108863)<<3)&536870911
r^=r>>11
return r+((r&16383)<<15)&536870911},
gbx(a){return A.Kx(t.N)},
$iy5:1,
$iqU:1}
A.SH.prototype={
"["(a){return"LateInitializationError: "+this.a}}
A.zl.prototype={}
A.bQ.prototype={}
A.aL.prototype={
gkz(a){var s=this
return new A.a7(s,s.gB(s),A.Lh(s).C("a7<aL.E>"))},
h(a,b){var s,r,q,p=this,o=p.gB(p)
if(b.length!==0){if(o===0)return""
s=A.I(p.F(0,0))
if(o!==p.gB(p))throw A.L(A.a4(p))
for(r=s,q=1;q<o;++q){r=r+b+A.I(p.F(0,q))
if(o!==p.gB(p))throw A.L(A.a4(p))}return r.charCodeAt(0)==0?r:r}else{for(q=0,r="";q<o;++q){r+=A.I(p.F(0,q))
if(o!==p.gB(p))throw A.L(A.a4(p))}return r.charCodeAt(0)==0?r:r}},
E2(a,b,c){return new A.A8(this,b,A.Lh(this).C("@<aL.E>").Kq(c).C("A8<1,2>"))}}
A.a7.prototype={
gl(){var s=this.d
return s==null?this.$ti.c.a(s):s},
G(){var s,r=this,q=r.a,p=J.U6(q),o=p.gB(q)
if(r.b!==o)throw A.L(A.a4(q))
s=r.c
if(s>=o){r.d=null
return!1}r.d=p.F(q,s);++r.c
return!0}}
A.i1.prototype={
gkz(a){var s=this.a
return new A.MH(s.gkz(s),this.b,A.Lh(this).C("MH<1,2>"))}}
A.xy.prototype={$ibQ:1}
A.MH.prototype={
G(){var s=this,r=s.b
if(r.G()){s.a=s.c.$1(r.gl())
return!0}s.a=null
return!1},
gl(){var s=this.a
return s==null?this.$ti.y[1].a(s):s}}
A.A8.prototype={
gB(a){return J.Hm(this.a)},
F(a,b){return this.b.$1(J.GA(this.a,b))}}
A.SU.prototype={}
A.S0.prototype={$r:"+code,id(1,2)",$s:1}
A.rY.prototype={}
A.t.prototype={
"["(a){var s=this.constructor,r=s==null?null:s.name
return"Closure '"+A.H(r==null?"unknown":r)+"'"},
gKu(){return this},
$C:"$1",
$R:1,
$D:null}
A.E1.prototype={$C:"$2",$R:2}
A.lc.prototype={}
A.zx.prototype={
"["(a){var s=this.$static_name
if(s==null)return"Closure of unknown static method"
return"Closure '"+A.H(s)+"'"}}
A.rT.prototype={
DN(a,b){if(b==null)return!1
if(this===b)return!0
if(!(b instanceof A.rT))return!1
return this.$_target===b.$_target&&this.a===b.a},
gi(a){return(A.CU(this.a)^A.eQ(this.$_target))>>>0},
"["(a){return"Closure '"+this.$_name+"' of "+("Instance of '"+A.l(this.a)+"'")}}
A.Eq.prototype={
"["(a){return"RuntimeError: "+this.a}}
A.N5.prototype={
gvc(){return new A.Gp(this,this.$ti.C("Gp<1>"))},
WH(a,b){var s,r,q,p,o=null
if(typeof b=="string"){s=this.b
if(s==null)return o
r=s[b]
q=r==null?o:r.b
return q}else if(typeof b=="number"&&(b&0x3fffffff)===b){p=this.c
if(p==null)return o
r=p[b]
q=r==null?o:r.b
return q}else return this.aa(b)},
aa(a){var s,r,q=this.d
if(q==null)return null
s=q[J.Nu(a)&1073741823]
r=this.X(s,a)
if(r<0)return null
return s[r].b},
t(a,b,c){var s,r,q,p,o,n,m=this
if(typeof b=="string"){s=m.b
m.m(s==null?m.b=m.A():s,b,c)}else if(typeof b=="number"&&(b&0x3fffffff)===b){r=m.c
m.m(r==null?m.c=m.A():r,b,c)}else{q=m.d
if(q==null)q=m.d=m.A()
p=J.Nu(b)&1073741823
o=q[p]
if(o==null)q[p]=[m.O(b,c)]
else{n=m.X(o,b)
if(n>=0)o[n].b=c
else o.push(m.O(b,c))}}},
j(a,b){var s=this.H4(this.b,b)
return s},
aN(a,b){var s=this,r=s.e,q=s.r
for(;r!=null;){b.$2(r.a,r.b)
if(q!==s.r)throw A.L(A.a4(s))
r=r.c}},
m(a,b,c){var s=a[b]
if(s==null)a[b]=this.O(b,c)
else s.b=c},
H4(a,b){var s
if(a==null)return null
s=a[b]
if(s==null)return null
this.GS(s)
delete a[b]
return s.b},
S(){this.r=this.r+1&1073741823},
O(a,b){var s,r=this,q=new A.vh(a,b)
if(r.e==null)r.e=r.f=q
else{s=r.f
s.toString
q.d=s
r.f=s.c=q}++r.a
r.S()
return q},
GS(a){var s=this,r=a.d,q=a.c
if(r==null)s.e=q
else r.c=q
if(q==null)s.f=r
else q.d=r;--s.a
s.S()},
X(a,b){var s,r
if(a==null)return-1
s=a.length
for(r=0;r<s;++r)if(J.cf(a[r].a,b))return r
return-1},
"["(a){return A.nO(this)},
A(){var s=Object.create(null)
s["<non-identifier-key>"]=s
delete s["<non-identifier-key>"]
return s}}
A.vh.prototype={}
A.Gp.prototype={
gkz(a){var s=this.a
return new A.N6(s,s.r,s.e)}}
A.N6.prototype={
gl(){return this.d},
G(){var s,r=this,q=r.a
if(r.b!==q.r)throw A.L(A.a4(q))
s=r.c
if(s==null){r.d=null
return!1}else{r.d=s.a
r.c=s.c
return!0}}}
A.dC.prototype={
$1(a){return this.a(a)}}
A.wN.prototype={
$2(a,b){return this.a(a,b)}}
A.VX.prototype={
$1(a){return this.a(a)}}
A.M.prototype={
"["(a){return this.k(!1)},
k(a){var s,r,q,p,o,n=this.D(),m=this.n(),l=(a?"Record ":"")+"("
for(s=n.length,r="",q=0;q<s;++q,r=", "){l+=r
p=n[q]
if(typeof p=="string")l=l+p+": "
o=m[q]
l=a?l+A.i(o):l+A.I(o)}l+=")"
return l.charCodeAt(0)==0?l:l},
D(){var s,r=this.$s
for(;$.Bi.length<=r;)$.Bi.push(null)
s=$.Bi[r]
if(s==null){s=this.J()
$.Bi[r]=s}return s},
J(){var s,r,q,p=this.$r,o=p.indexOf("("),n=p.substring(1,o),m=p.substring(o),l=m==="()"?0:m.replace(/[^,]/g,"").length+1,k=A.j(new Array(l),t.f)
for(s=0;s<l;++s)k[s]=s
if(n!==""){r=n.split(",")
s=r.length
for(q=l;s>0;){--q;--s
k[q]=r[s]}}k=A.PW(k,!1,t.K)
k.$flags=3
return k}}
A.B7.prototype={
n(){return[this.a,this.b]},
DN(a,b){if(b==null)return!1
return b instanceof A.B7&&this.$s===b.$s&&J.cf(this.a,b.a)&&J.cf(this.b,b.b)},
gi(a){return A.f5(this.$s,this.a,this.b,B.zt)}}
A.VR.prototype={
"["(a){return"RegExp/"+this.a+"/"+this.b.flags}}
A.WZ.prototype={
gbx(a){return B.lb},
$iy5:1,
$iI2:1}
A.eH.prototype={}
A.df.prototype={
gbx(a){return B.LV},
$iy5:1,
$iWy:1}
A.b0.prototype={
gB(a){return a.length},
$iXj:1}
A.Dg.prototype={$ibQ:1,$icX:1,$izM:1}
A.DV.prototype={$ibQ:1,$icX:1,$izM:1}
A.zU.prototype={
gbx(a){return B.Vr},
$iy5:1,
$ioI:1}
A.K8.prototype={
gbx(a){return B.mB},
$iy5:1,
$imJ:1}
A.xj.prototype={
gbx(a){return B.x9},
$iy5:1,
$irF:1}
A.dE.prototype={
gbx(a){return B.G3},
$iy5:1,
$iX6:1}
A.Zc.prototype={
gbx(a){return B.xg},
$iy5:1,
$iZX:1}
A.wf.prototype={
gbx(a){return B.Ry},
$iy5:1,
$iHS:1}
A.Pq.prototype={
gbx(a){return B.zo},
$iy5:1,
$iPz:1}
A.eE.prototype={
gbx(a){return B.xU},
gB(a){return a.length},
$iy5:1,
$izt:1}
A.V6.prototype={
gbx(a){return B.iY},
gB(a){return a.length},
$iy5:1,
$in6:1}
A.RG.prototype={}
A.vX.prototype={}
A.WB.prototype={}
A.VS.prototype={}
A.Jc.prototype={
C(a){return A.cE(v.typeUniverse,this,a)},
Kq(a){return A.v5(v.typeUniverse,this,a)}}
A.ET.prototype={}
A.lY.prototype={
"["(a){return A.d(this.a,null)}}
A.u9.prototype={
"["(a){return this.a}}
A.iM.prototype={}
A.k6.prototype={
gvc(){return new A.Ni(this,this.$ti.C("Ni<1>"))},
x4(a){var s,r
if(typeof a=="string"&&a!=="__proto__"){s=this.b
return s==null?!1:s[a]!=null}else if(typeof a=="number"&&(a&1073741823)===a){r=this.c
return r==null?!1:r[a]!=null}else return this.KY(a)},
KY(a){var s=this.d
if(s==null)return!1
return this.DF(this.e1(s,a),a)>=0},
WH(a,b){var s,r,q
if(typeof b=="string"&&b!=="__proto__"){s=this.b
r=s==null?null:A.vL(s,b)
return r}else if(typeof b=="number"&&(b&1073741823)===b){q=this.c
r=q==null?null:A.vL(q,b)
return r}else return this.c8(b)},
c8(a){var s,r,q=this.d
if(q==null)return null
s=this.e1(q,a)
r=this.DF(s,a)
return r<0?null:s[r+1]},
t(a,b,c){var s,r,q,p=this,o=p.d
if(o==null)o=p.d=A.a0()
s=A.CU(b)&1073741823
r=o[s]
if(r==null){A.a8(o,s,[b,c]);++p.a
p.e=null}else{q=p.DF(r,b)
if(q>=0)r[q+1]=c
else{r.push(b,c);++p.a
p.e=null}}},
aN(a,b){var s,r,q,p,o,n=this,m=n.Cf()
for(s=m.length,r=n.$ti.y[1],q=0;q<s;++q){p=m[q]
o=n.WH(0,p)
b.$2(p,o==null?r.a(o):o)
if(m!==n.e)throw A.L(A.a4(n))}},
Cf(){var s,r,q,p,o,n,m,l,k,j,i=this,h=i.e
if(h!=null)return h
h=A.O8(i.a,null,t.z)
s=i.b
r=0
if(s!=null){q=Object.getOwnPropertyNames(s)
p=q.length
for(o=0;o<p;++o){h[r]=q[o];++r}}n=i.c
if(n!=null){q=Object.getOwnPropertyNames(n)
p=q.length
for(o=0;o<p;++o){h[r]=+q[o];++r}}m=i.d
if(m!=null){q=Object.getOwnPropertyNames(m)
p=q.length
for(o=0;o<p;++o){l=m[q[o]]
k=l.length
for(j=0;j<k;j+=2){h[r]=l[j];++r}}}return i.e=h},
e1(a,b){return a[A.CU(b)&1073741823]}}
A.YF.prototype={
DF(a,b){var s,r,q
if(a==null)return-1
s=a.length
for(r=0;r<s;r+=2){q=a[r]
if(q==null?b==null:q===b)return r}return-1}}
A.Ni.prototype={
gkz(a){var s=this.a
return new A.t3(s,s.Cf(),this.$ti.C("t3<1>"))}}
A.t3.prototype={
gl(){var s=this.d
return s==null?this.$ti.c.a(s):s},
G(){var s=this,r=s.b,q=s.c,p=s.a
if(r!==p.e)throw A.L(A.a4(p))
else if(q>=r.length){s.d=null
return!1}else{s.d=r[q]
s.c=q+1
return!0}}}
A.F.prototype={
gkz(a){return new A.a7(a,a.length,A.z(a).C("a7<F.E>"))},
F(a,b){return a[b]},
E2(a,b,c){return new A.A8(a,b,A.z(a).C("@<F.E>").Kq(c).C("A8<1,2>"))},
"["(a){return A.x(a,"[","]")}}
A.il.prototype={
aN(a,b){var s,r,q,p
for(s=this.gvc(),s=s.gkz(s),r=A.Lh(this).y[1];s.G();){q=s.gl()
p=this.WH(0,q)
b.$2(q,p==null?r.a(p):p)}},
"["(a){return A.nO(this)}}
A.mN.prototype={
$2(a,b){var s,r=this.a
if(!r.a)this.b.a+=", "
r.a=!1
r=this.b
s=A.I(a)
r.a=(r.a+=s)+": "
s=A.I(b)
r.a+=s}}
A.Uk.prototype={}
A.wI.prototype={}
A.Zi.prototype={}
A.u5.prototype={}
A.E3.prototype={
W(a){var s,r,q,p=A.jB(0,null,a.length)
if(p===0)return new Uint8Array(0)
s=p*3
r=new Uint8Array(s)
q=new A.Rw(r)
if(q.T(a,0,p)!==p)q.H()
return new Uint8Array(r.subarray(0,A.rM(0,q.b,s)))}}
A.Rw.prototype={
H(){var s=this,r=s.c,q=s.b,p=s.b=q+1
r.$flags&2&&A.cW(r)
r[q]=239
q=s.b=p+1
r[p]=191
s.b=q+1
r[q]=189},
O6(a,b){var s,r,q,p,o=this
if((b&64512)===56320){s=65536+((a&1023)<<10)|b&1023
r=o.c
q=o.b
p=o.b=q+1
r.$flags&2&&A.cW(r)
r[q]=s>>>18|240
q=o.b=p+1
r[p]=s>>>12&63|128
p=o.b=q+1
r[q]=s>>>6&63|128
o.b=p+1
r[p]=s&63|128
return!0}else{o.H()
return!1}},
T(a,b,c){var s,r,q,p,o,n,m,l,k=this
if(b!==c&&(a.charCodeAt(c-1)&64512)===55296)--c
for(s=k.c,r=s.$flags|0,q=s.length,p=b;p<c;++p){o=a.charCodeAt(p)
if(o<=127){n=k.b
if(n>=q)break
k.b=n+1
r&2&&A.cW(s)
s[n]=o}else{n=o&64512
if(n===55296){if(k.b+4>q)break
m=p+1
if(k.O6(o,a.charCodeAt(m)))p=m}else if(n===56320){if(k.b+3>q)break
k.H()}else if(o<=2047){n=k.b
l=n+1
if(l>=q)break
k.b=l
r&2&&A.cW(s)
s[n]=o>>>6|192
k.b=l+1
s[l]=o&63|128}else{n=k.b
if(n+2>=q)break
l=k.b=n+1
r&2&&A.cW(s)
s[n]=o>>>12|224
n=k.b=l+1
s[l]=o>>>6&63|128
k.b=n+1
s[n]=o&63|128}}}return p}}
A.bp.prototype={
$2(a,b){var s,r
if(typeof b=="string")this.a.set(a,b)
else if(b==null)this.a.set(a,"")
else for(s=J.IT(b),r=this.a;s.G();){b=s.gl()
if(typeof b=="string")r.append(a,b)
else if(b==null)r.append(a,"")
else A.ra(b)}}}
A.Ge.prototype={}
A.C6.prototype={
"["(a){var s=this.a
if(s!=null)return"Assertion failed: "+A.h(s)
return"Assertion failed"}}
A.E.prototype={}
A.AT.prototype={
gZ(){return"Invalid argument"+(!this.a?"(s)":"")},
gN(){return""},
"["(a){var s=this,r=s.c,q=r==null?"":" ("+r+")",p=s.d,o=p==null?"":": "+p,n=s.gZ()+q+o
if(!s.a)return n
return n+s.gN()+": "+A.h(s.gE())},
gE(){return this.b}}
A.bJ.prototype={
gE(){return this.b},
gZ(){return"RangeError"},
gN(){var s,r=this.e,q=this.f
if(r==null)s=q!=null?": Not less than or equal to "+A.I(q):""
else if(q==null)s=": Not greater than or equal to "+A.I(r)
else if(q>r)s=": Not in inclusive range "+A.I(r)+".."+A.I(q)
else s=q<r?": Valid value range is empty":": Only valid value is "+A.I(r)
return s}}
A.eY.prototype={
gE(){return this.b},
gZ(){return"RangeError"},
gN(){if(this.b<0)return": index must not be negative"
var s=this.f
if(s===0)return": no indices are valid"
return": index should be less than "+s}}
A.ub.prototype={
"["(a){return"Unsupported operation: "+this.a}}
A.ds.prototype={
"["(a){return"UnimplementedError: "+this.a}}
A.lj.prototype={
"["(a){return"Bad state: "+this.a}}
A.UV.prototype={
"["(a){var s=this.a
if(s==null)return"Concurrent modification during iteration."
return"Concurrent modification during iteration: "+A.h(s)+"."}}
A.k5.prototype={
"["(a){return"Out of Memory"}}
A.aE.prototype={
"["(a){var s,r,q,p,o,n,m,l,k,j,i,h=this.a,g=""!==h?"FormatException: "+h:"FormatException",f=this.c,e=this.b
if(typeof e=="string"){if(f!=null)s=f<0||f>e.length
else s=!1
if(s)f=null
if(f==null){if(e.length>78)e=B.xB.Nj(e,0,75)+"..."
return g+"\n"+e}for(r=1,q=0,p=!1,o=0;o<f;++o){n=e.charCodeAt(o)
if(n===10){if(q!==o||!p)++r
q=o+1
p=!1}else if(n===13){++r
q=o+1
p=!0}}g=r>1?g+(" (at line "+r+", character "+(f-q+1)+")\n"):g+(" (at character "+(f+1)+")\n")
m=e.length
for(o=f;o<m;++o){n=e.charCodeAt(o)
if(n===10||n===13){m=o
break}}l=""
if(m-q>78){k="..."
if(f-q<75){j=q+75
i=q}else{if(m-f<75){i=m-75
j=m
k=""}else{i=f-36
j=f+36}l="..."}}else{j=m
i=q
k=""}return g+l+B.xB.Nj(e,i,j)+k+"\n"+B.xB.Ix(" ",f-i+l.length)+"^\n"}else return f!=null?g+(" (at offset "+A.I(f)+")"):g}}
A.cX.prototype={
E2(a,b,c){return A.K1(this,b,A.Lh(this).C("cX.E"),c)},
gB(a){var s,r=this.gkz(this)
for(s=0;r.G();)++s
return s},
F(a,b){var s,r
A.k1(b,"index")
s=this.gkz(this)
for(r=b;s.G();){if(r===0)return s.gl();--r}throw A.L(A.xF(b,b-r,this,"index"))},
"["(a){return A.Sd(this,"(",")")}}
A.c8.prototype={
gi(a){return A.a.prototype.gi.call(this,0)},
"["(a){return"null"}}
A.a.prototype={$ia:1,
DN(a,b){return this===b},
gi(a){return A.eQ(this)},
"["(a){return"Instance of '"+A.l(this)+"'"},
gbx(a){return A.RW(this)},
toString(){return this["["](this)}}
A.Rn.prototype={
"["(a){var s=this.a
return s.charCodeAt(0)==0?s:s}}
A.cS.prototype={
$2(a,b){throw A.L(A.rr("Illegal IPv4 address, "+a,this.a,b))}}
A.VC.prototype={
$2(a,b){throw A.L(A.rr("Illegal IPv6 address, "+a,this.a,b))}}
A.JT.prototype={
$2(a,b){var s
if(b-a>4)this.a.$2("an IPv6 part can only contain a maximum of 4 hex digits",a)
s=A.QA(B.xB.Nj(this.b,a,b),16)
if(s<0||s>65535)this.a.$2("each part must be in the range of `0x0..0xFFFF`",a)
return s}}
A.Dn.prototype={
gL(){var s,r,q,p,o=this,n=o.w
if(n===$){s=o.a
r=s.length!==0?s+":":""
q=o.c
p=q==null
if(!p||s==="file"){s=r+"//"
r=o.b
if(r.length!==0)s=s+r+"@"
if(!p)s+=q
r=o.d
if(r!=null)s=s+":"+A.I(r)}else s=r
s+=o.e
r=o.f
if(r!=null)s=s+"?"+r
r=o.r
if(r!=null)s=s+"#"+r
n!==$&&A.kL()
n=o.w=s.charCodeAt(0)==0?s:s}return n},
gi(a){var s,r=this,q=r.y
if(q===$){s=B.xB.gi(r.gL())
r.y!==$&&A.kL()
r.y=s
q=s}return q},
gq(){var s=this.c
if(s==null)return""
if(B.xB.v(s,"[")&&!B.xB.Y(s,"v",1))return B.xB.Nj(s,1,s.length-1)
return s},
gtp(){var s=this.d
return s==null?A.wK(this.a):s},
"["(a){return this.gL()},
DN(a,b){var s,r,q,p,o,n=this
if(b==null)return!1
if(n===b)return!0
s=!1
if(b instanceof A.Dn)if(n.a===b.a)if(n.c!=null===(b.c!=null))if(n.b===b.b)if(n.gq()===b.gq())if(n.gtp()===b.gtp())if(n.e===b.e){r=n.f
q=r==null
p=b.f
o=p==null
if(!q===!o){if(q)r=""
if(r===(o?"":p)){r=n.r
q=r==null
p=b.r
o=p==null
if(!q===!o){s=q?"":r
s=s===(o?"":p)}}}}return s}}
A.RZ.prototype={
$1(a){return A.eP(64,a,B.xM,!1)}}
A.IP.prototype={
$2(a,b){var s=this.b,r=this.a
s.a+=r.a
r.a="&"
r=A.eP(1,a,B.xM,!0)
r=s.a+=r
if(b!=null&&b.length!==0){s.a=r+"="
r=A.eP(1,b,B.xM,!0)
s.a+=r}}}
A.fq.prototype={
$2(a,b){var s,r
if(b==null||typeof b=="string")this.a.$2(a,b)
else for(s=J.IT(b),r=this.a;s.G();)r.$2(a,s.gl())}}
A.Pb.prototype={
$1(a){var s,r,q,p
if(A.m6(a))return a
s=this.a
if(s.x4(a))return s.WH(0,a)
if(a instanceof A.il){r={}
s.t(0,a,r)
for(s=a.gvc(),s=s.gkz(s);s.G();){q=s.gl()
r[q]=this.$1(a.WH(0,q))}return r}else if(t.V.b(a)){p=[]
s.t(0,a,p)
B.Nm.FV(p,J.M1(a,this,t.z))
return p}else return a}}
A.lM.prototype={}
A.YE.prototype={
U(){this.a=Math.max(18,5)},
W(a){var s,r,q,p,o,n,m,l,k,j,i,h,g,f
if(!B.xB.I(a,"&"))return a
s=new A.Rn("")
for(r=a.length,q=0;!0;){p=B.xB.K(a,"&",q)
if(p===-1){s.a+=B.xB.yn(a,q)
break}o=s.a+=B.xB.Nj(a,q,p)
n=this.a
n===$&&A.Q4()
m=B.xB.Nj(a,p,Math.min(r,p+n))
if(m.length>4&&m.charCodeAt(1)===35){l=B.xB.M(m,";")
if(l!==-1){k=m.charCodeAt(2)===120
j=B.xB.Nj(m,k?3:2,l)
i=A.Hp(j,k?16:10)
if(i==null)i=-1
if(i!==-1){s.a=o+A.Lw(i)
q=p+(l+1)
continue}}}g=0
while(!0){if(!(g<268)){q=p
h=!1
break}f=B.uu[g]
if(B.xB.v(m,f)){s.a+=B.nO[g]
q=p+f.length
h=!0
break}++g}if(!h){s.a+="&";++q}}r=s.a
return r.charCodeAt(0)==0?r:r}}
A.TZ.prototype={}
A.e.prototype={
$1(a){var s,r,q,p,o,n,m=null,l=a.data,k=t.m,j=m,i=!1
if(k.b(l)){s=l.type
r=s
if(r!=null){q=s==null?A.Bt(s):s
p=l.sender
r=p
if(r!=null){j=p==null?A.Bt(p):p
i=q==="ready"}}}if(i){i=this.a
o=i.WH(0,j)
if(o!=null){n=v.G.document.getElementById(j)
if(n==null)n=k.a(n)
k=A.hy(n.contentWindow)
if(k!=null){r=t.N
r=A.Pe(A.EF(["sourceCode",o,"type","sourceCode"],r,r))
k.a.postMessage(r,"*")}i.j(0,j)}}}};(function aliases(){var s=J.u0.prototype
s.u=s["["]})();(function inheritance(){var s=hunkHelpers.mixin,r=hunkHelpers.inherit,q=hunkHelpers.inheritMany
r(A.a,null)
q(A.a,[A.FK,J.vB,A.rY,J.D,A.Ge,A.zl,A.cX,A.a7,A.MH,A.SU,A.M,A.t,A.il,A.vh,A.N6,A.VR,A.Jc,A.ET,A.lY,A.t3,A.F,A.Uk,A.wI,A.Rw,A.k5,A.aE,A.c8,A.Rn,A.Dn,A.TZ])
q(J.vB,[J.yE,J.CD,J.MF,J.rQ,J.Dw,J.qI,J.Dr])
q(J.MF,[J.u0,J.p,A.WZ,A.eH])
q(J.u0,[J.iC,J.kd,J.c5])
r(J.B,A.rY)
r(J.Po,J.p)
q(J.qI,[J.im,J.kD])
q(A.Ge,[A.SH,A.Eq,A.u9,A.C6,A.E,A.AT,A.ub,A.ds,A.lj,A.UV])
q(A.cX,[A.bQ,A.i1])
q(A.bQ,[A.aL,A.Gp,A.Ni])
r(A.xy,A.i1)
r(A.A8,A.aL)
r(A.B7,A.M)
r(A.S0,A.B7)
q(A.t,[A.E1,A.lc,A.dC,A.VX,A.RZ,A.Pb,A.e])
q(A.lc,[A.zx,A.rT])
q(A.il,[A.N5,A.k6])
q(A.E1,[A.wN,A.mN,A.bp,A.cS,A.VC,A.JT,A.IP,A.fq])
q(A.eH,[A.df,A.b0])
q(A.b0,[A.RG,A.WB])
r(A.vX,A.RG)
r(A.Dg,A.vX)
r(A.VS,A.WB)
r(A.DV,A.VS)
q(A.Dg,[A.zU,A.K8])
q(A.DV,[A.xj,A.dE,A.Zc,A.wf,A.Pq,A.eE,A.V6])
r(A.iM,A.u9)
r(A.YF,A.k6)
r(A.Zi,A.Uk)
r(A.u5,A.Zi)
q(A.wI,[A.E3,A.YE])
q(A.AT,[A.bJ,A.eY])
r(A.lM,A.YE)
s(A.RG,A.F)
s(A.vX,A.SU)
s(A.WB,A.F)
s(A.VS,A.SU)})()
var v={G:typeof self!="undefined"?self:globalThis,typeUniverse:{eC:new Map(),tR:{},eT:{},tPV:{},sEA:[]},mangledGlobalNames:{KN:"int",CP:"double",lf:"num",qU:"String",a2:"bool",c8:"Null",zM:"List",a:"Object",T8:"Map"},mangledNames:{},types:[],interceptorsByTag:null,leafTags:null,arrayRti:Symbol("$ti"),rttc:{"2;code,id":(a,b)=>c=>c instanceof A.S0&&a.b(c.a)&&b.b(c.b)}}
A.xb(v.typeUniverse,JSON.parse('{"iC":"u0","kd":"u0","c5":"u0","yE":{"y5":[]},"CD":{"y5":[]},"MF":{"vm":[]},"u0":{"vm":[]},"p":{"zM":["1"],"bQ":["1"],"vm":[],"cX":["1"]},"B":{"rY":[]},"Po":{"p":["1"],"zM":["1"],"bQ":["1"],"vm":[],"cX":["1"]},"qI":{"CP":[]},"im":{"CP":[],"KN":[],"y5":[]},"kD":{"CP":[],"y5":[]},"Dr":{"qU":[],"y5":[]},"bQ":{"cX":["1"]},"aL":{"bQ":["1"],"cX":["1"]},"i1":{"cX":["2"],"cX.E":"2"},"xy":{"i1":["1","2"],"bQ":["2"],"cX":["2"],"cX.E":"2"},"A8":{"aL":["2"],"bQ":["2"],"cX":["2"],"aL.E":"2","cX.E":"2"},"N5":{"il":["1","2"]},"Gp":{"bQ":["1"],"cX":["1"],"cX.E":"1"},"WZ":{"vm":[],"I2":[],"y5":[]},"eH":{"vm":[]},"df":{"Wy":[],"vm":[],"y5":[]},"b0":{"Xj":["1"],"vm":[]},"Dg":{"F":["CP"],"zM":["CP"],"Xj":["CP"],"bQ":["CP"],"vm":[],"cX":["CP"]},"DV":{"F":["KN"],"zM":["KN"],"Xj":["KN"],"bQ":["KN"],"vm":[],"cX":["KN"]},"zU":{"oI":[],"F":["CP"],"zM":["CP"],"Xj":["CP"],"bQ":["CP"],"vm":[],"cX":["CP"],"y5":[],"F.E":"CP"},"K8":{"mJ":[],"F":["CP"],"zM":["CP"],"Xj":["CP"],"bQ":["CP"],"vm":[],"cX":["CP"],"y5":[],"F.E":"CP"},"xj":{"rF":[],"F":["KN"],"zM":["KN"],"Xj":["KN"],"bQ":["KN"],"vm":[],"cX":["KN"],"y5":[],"F.E":"KN"},"dE":{"X6":[],"F":["KN"],"zM":["KN"],"Xj":["KN"],"bQ":["KN"],"vm":[],"cX":["KN"],"y5":[],"F.E":"KN"},"Zc":{"ZX":[],"F":["KN"],"zM":["KN"],"Xj":["KN"],"bQ":["KN"],"vm":[],"cX":["KN"],"y5":[],"F.E":"KN"},"wf":{"HS":[],"F":["KN"],"zM":["KN"],"Xj":["KN"],"bQ":["KN"],"vm":[],"cX":["KN"],"y5":[],"F.E":"KN"},"Pq":{"Pz":[],"F":["KN"],"zM":["KN"],"Xj":["KN"],"bQ":["KN"],"vm":[],"cX":["KN"],"y5":[],"F.E":"KN"},"eE":{"zt":[],"F":["KN"],"zM":["KN"],"Xj":["KN"],"bQ":["KN"],"vm":[],"cX":["KN"],"y5":[],"F.E":"KN"},"V6":{"n6":[],"F":["KN"],"zM":["KN"],"Xj":["KN"],"bQ":["KN"],"vm":[],"cX":["KN"],"y5":[],"F.E":"KN"},"k6":{"il":["1","2"]},"YF":{"k6":["1","2"],"il":["1","2"]},"Ni":{"bQ":["1"],"cX":["1"],"cX.E":"1"},"zM":{"bQ":["1"],"cX":["1"]},"ZX":{"zM":["KN"],"bQ":["KN"],"cX":["KN"]},"n6":{"zM":["KN"],"bQ":["KN"],"cX":["KN"]},"zt":{"zM":["KN"],"bQ":["KN"],"cX":["KN"]},"rF":{"zM":["KN"],"bQ":["KN"],"cX":["KN"]},"HS":{"zM":["KN"],"bQ":["KN"],"cX":["KN"]},"X6":{"zM":["KN"],"bQ":["KN"],"cX":["KN"]},"Pz":{"zM":["KN"],"bQ":["KN"],"cX":["KN"]},"oI":{"zM":["CP"],"bQ":["CP"],"cX":["CP"]},"mJ":{"zM":["CP"],"bQ":["CP"],"cX":["CP"]}}'))
A.FF(v.typeUniverse,JSON.parse('{"bQ":1,"SU":1,"N6":1,"b0":1,"Uk":2,"wI":2}'))
var u={b:"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\u03f6\x00\u0404\u03f4 \u03f4\u03f6\u01f6\u01f6\u03f6\u03fc\u01f4\u03ff\u03ff\u0584\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u05d4\u01f4\x00\u01f4\x00\u0504\u05c4\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u0400\x00\u0400\u0200\u03f7\u0200\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u03ff\u0200\u0200\u0200\u03f7\x00"}
var t=(function rtii(){var s=A.q7
return{J:s("I2"),Y:s("Wy"),Q:s("bQ<@>"),B:s("oI"),q:s("mJ"),Z:s("EH"),O:s("rF"),k:s("X6"),U:s("ZX"),V:s("cX<@>"),f:s("p<a>"),s:s("p<qU>"),b:s("p<@>"),t:s("p<KN>"),T:s("CD"),m:s("vm"),g:s("c5"),p:s("Xj<@>"),j:s("zM<@>"),P:s("c8"),K:s("a"),L:s("VY"),F:s("+()"),N:s("qU"),R:s("y5"),D:s("HS"),v:s("Pz"),e:s("zt"),E:s("n6"),o:s("kd"),A:s("YF<a?,a?>"),y:s("a2"),i:s("CP"),z:s("@"),S:s("KN"),W:s("b8<c8>?"),X:s("a?"),w:s("qU?"),u:s("a2?"),I:s("CP?"),x:s("KN?"),n:s("lf?"),H:s("lf")}})();(function constants(){var s=hunkHelpers.makeConstList
B.Ok=J.vB.prototype
B.Nm=J.p.prototype
B.jn=J.im.prototype
B.xB=J.Dr.prototype
B.DG=J.c5.prototype
B.Ub=J.MF.prototype
B.ZQ=J.iC.prototype
B.vB=J.kd.prototype
B.O4=function getTagFallback(o) {
  var s = Object.prototype.toString.call(o);
  return s.substring(8, s.length - 1);
}
B.Yq=function() {
  var toStringFunction = Object.prototype.toString;
  function getTag(o) {
    var s = toStringFunction.call(o);
    return s.substring(8, s.length - 1);
  }
  function getUnknownTag(object, tag) {
    if (/^HTML[A-Z].*Element$/.test(tag)) {
      var name = toStringFunction.call(object);
      if (name == "[object Object]") return null;
      return "HTMLElement";
    }
  }
  function getUnknownTagGenericBrowser(object, tag) {
    if (object instanceof HTMLElement) return "HTMLElement";
    return getUnknownTag(object, tag);
  }
  function prototypeForTag(tag) {
    if (typeof window == "undefined") return null;
    if (typeof window[tag] == "undefined") return null;
    var constructor = window[tag];
    if (typeof constructor != "function") return null;
    return constructor.prototype;
  }
  function discriminator(tag) { return null; }
  var isBrowser = typeof HTMLElement == "function";
  return {
    getTag: getTag,
    getUnknownTag: isBrowser ? getUnknownTagGenericBrowser : getUnknownTag,
    prototypeForTag: prototypeForTag,
    discriminator: discriminator };
}
B.wb=function(getTagFallback) {
  return function(hooks) {
    if (typeof navigator != "object") return hooks;
    var userAgent = navigator.userAgent;
    if (typeof userAgent != "string") return hooks;
    if (userAgent.indexOf("DumpRenderTree") >= 0) return hooks;
    if (userAgent.indexOf("Chrome") >= 0) {
      function confirm(p) {
        return typeof window == "object" && window[p] && window[p].name == p;
      }
      if (confirm("Window") && confirm("HTMLElement")) return hooks;
    }
    hooks.getTag = getTagFallback;
  };
}
B.KU=function(hooks) {
  if (typeof dartExperimentalFixupGetTag != "function") return hooks;
  hooks.getTag = dartExperimentalFixupGetTag(hooks.getTag);
}
B.dk=function(hooks) {
  if (typeof navigator != "object") return hooks;
  var userAgent = navigator.userAgent;
  if (typeof userAgent != "string") return hooks;
  if (userAgent.indexOf("Firefox") == -1) return hooks;
  var getTag = hooks.getTag;
  var quickMap = {
    "BeforeUnloadEvent": "Event",
    "DataTransfer": "Clipboard",
    "GeoGeolocation": "Geolocation",
    "Location": "!Location",
    "WorkerMessageEvent": "MessageEvent",
    "XMLDocument": "!Document"};
  function getTagFirefox(o) {
    var tag = getTag(o);
    return quickMap[tag] || tag;
  }
  hooks.getTag = getTagFirefox;
}
B.xi=function(hooks) {
  if (typeof navigator != "object") return hooks;
  var userAgent = navigator.userAgent;
  if (typeof userAgent != "string") return hooks;
  if (userAgent.indexOf("Trident/") == -1) return hooks;
  var getTag = hooks.getTag;
  var quickMap = {
    "BeforeUnloadEvent": "Event",
    "DataTransfer": "Clipboard",
    "HTMLDDElement": "HTMLElement",
    "HTMLDTElement": "HTMLElement",
    "HTMLPhraseElement": "HTMLElement",
    "Position": "Geoposition"
  };
  function getTagIE(o) {
    var tag = getTag(o);
    var newTag = quickMap[tag];
    if (newTag) return newTag;
    if (tag == "Object") {
      if (window.DataView && (o instanceof window.DataView)) return "DataView";
    }
    return tag;
  }
  function prototypeForTagIE(tag) {
    var constructor = window[tag];
    if (constructor == null) return null;
    return constructor.prototype;
  }
  hooks.getTag = getTagIE;
  hooks.prototypeForTag = prototypeForTagIE;
}
B.fQ=function(hooks) {
  var getTag = hooks.getTag;
  var prototypeForTag = hooks.prototypeForTag;
  function getTagFixed(o) {
    var tag = getTag(o);
    if (tag == "Document") {
      if (!!o.xmlVersion) return "!Document";
      return "!HTMLDocument";
    }
    return tag;
  }
  function prototypeForTagFixed(tag) {
    if (tag == "Document") return null;
    return prototypeForTag(tag);
  }
  hooks.getTag = getTagFixed;
  hooks.prototypeForTag = prototypeForTagFixed;
}
B.i7=function(hooks) { return hooks; }

B.Eq=new A.k5()
B.zt=new A.zl()
B.xM=new A.u5()
B.Qk=new A.E3()
B.nO=s(["`","\xa0","\xb4","|","\xb7","\xa8","\xb1","\xb7","_","\xae","\xb8","\n","\xa6","%","*","{","|",".","}","\xfd","\xa4","\xfa","\xf5","=","\xf9","@","\xf8","\xb1","\xf7","[","$","\xb7","]","\xd3","_","\xbc","\xbd","\xbe","\xbf","\xc0","\xc1","\xc3","\xf3","\xc8","\xc9","\xcc","\xcd","\xd1","\xd2","\xd5","\xd8","\xd9","\xda","\xdd","\xe0","\xe1","\xe3","\xe7","\xe8","\xe9","\xec","\xed","\xf1","\xf2","\xc7","\xea","\xb4","\xa4","\xf4","\xa6","\xf3","\xa3","\xf2","\xf9","\xf1",":","\xab","\xee","\xf8","\xed","\xfe","\xfd","\xf7","\xc8","\xec","\xaf","\xa1","\xb1","\xe9","\xdf","\xe8","\xb5","\xe7","\xb7","\xb8","\xfb","\xe6",",","\xbb","\xfa","\xbc","\xbd","?","\xbe","\xbf","\xc0","\xc1","\xc2","\xc3","\xc5","\xc5","\xc6","\xe5","\xde","\xc9","\xca","\xcc","\xe3","\xcd","\xce","\xe2","`","\xd1","\xd2","\xe1","\xd3","\xd4","f","\xd5","\xe0","\xd7","\xf5","\xd8","\xd9","\xda","\xdb","\xdd","\xc7","\xaf","\xb2","[",";","\xb3","\xc2","\\","+","\xc4","\xe5","\xf4","\xb4","\xc5","\xa7","\xc6","\xa9","\xb5","]","\xd7","\xff","\xb6","\xa2","\xca","\xcb","\xe4","\xfe","\xa0","\xfc","\xf6","\xfb","\xce","\xcf","}","\xe2","\xa9","\xb8","\xa1","'","\xb9","\xaa","\xba","\xef","\xd4","\xa3","\xbb","\xd6","\xab","\xeb",">","(",'"',"{","\xbd",")","\xee","\xea","\xdb","\xdc","\xdf","|","!","<","\xde",'"',"\xe6","=","\xd6",'"',"\xff","\xf6","\xd0","\xcf","&","\xcb","\xe4","&","\xc4","\xb9","\xba","*","\xb6","\xa0","#","\xb3","\xb2","\xad","\xfc","\xf7","\xeb","\xb0","\xaf","\xae","\xae","\xdc","\xac","\xaa","\xef","\xf0","\xa9","\xa9","\xa8","\xa2","\xa8","\xa8","\xa7","/",'"',"\xa5","\t","^","\xd0","\xb1","\xb0","\xae","\xae","\xad","\xac","\xa8","\xa5",">",">","<","<","&","&","\xf0",">",">","<","<"],t.s)
B.uu=s(["&DiacriticalGrave;","&NonBreakingSpace;","&DiacriticalAcute;","&VerticalLine;","&centerdot;","&DoubleDot;","&PlusMinus;","&CenterDot;","&UnderBar;","&circledR;","&Cedilla;","&NewLine;","&brvbar;","&percnt;","&midast;","&lbrace;","&verbar;","&period;","&rbrace;","&yacute;","&curren;","&uacute;","&otilde;","&equals;","&ugrave;","&commat;","&oslash;","&plusmn;","&divide;","&lbrack;","&dollar;","&middot;","&rbrack;","&Oacute;","&lowbar;","&frac14;","&frac12;","&frac34;","&iquest;","&Agrave;","&Aacute;","&Atilde;","&oacute;","&Egrave;","&Eacute;","&Igrave;","&Iacute;","&Ntilde;","&Ograve;","&Otilde;","&Oslash;","&Ugrave;","&Uacute;","&Yacute;","&agrave;","&aacute;","&atilde;","&ccedil;","&egrave;","&eacute;","&igrave;","&iacute;","&ntilde;","&ograve;","&Ccedil;","&ecirc;","&acute;","&curren","&ocirc;","&brvbar","&oacute","&pound;","&ograve","&ugrave","&ntilde","&colon;","&laquo;","&icirc;","&oslash","&iacute","&thorn;","&yacute","&divide","&Egrave","&igrave","&strns;","&iexcl;","&plusmn","&eacute","&szlig;","&egrave","&micro;","&ccedil","&middot","&cedil;","&ucirc;","&aelig;","&comma;","&raquo;","&uacute","&frac14","&frac12","&quest;","&frac34","&iquest","&Agrave","&Aacute","&Acirc;","&Atilde","&Aring;","&angst;","&AElig;","&aring;","&THORN;","&Eacute","&Ecirc;","&Igrave","&atilde","&Iacute","&Icirc;","&acirc;","&grave;","&Ntilde","&Ograve","&aacute","&Oacute","&Ocirc;","&fjlig;","&Otilde","&agrave","&times;","&otilde","&Oslash","&Ugrave","&Uacute","&Ucirc;","&Yacute","&Ccedil","&macr;","&sup2;","&lsqb;","&semi;","&sup3;","&Acirc","&bsol;","&plus;","&Auml;","&aring","&ocirc","&acute","&Aring","&sect;","&AElig","&copy;","&micro","&rsqb;","&times","&yuml;","&para;","&cent;","&Ecirc","&Euml;","&auml;","&thorn","&nbsp;","&uuml;","&ouml;","&ucirc","&Icirc","&Iuml;","&rcub;","&acirc","&COPY;","&cedil","&iexcl","&apos;","&sup1;","&ordf;","&ordm;","&iuml;","&Ocirc","&pound","&raquo","&Ouml;","&laquo","&euml;","&nvgt;","&lpar;","&QUOT;","&lcub;","&half;","&rpar;","&icirc","&ecirc","&Ucirc","&Uuml;","&szlig","&vert;","&excl;","&nvlt;","&THORN","&quot;","&aelig","&bne;","&Ouml","&quot","&yuml","&ouml","&ETH;","&Iuml","&AMP;","&Euml","&auml","&amp;","&Auml","&sup1","&ordm","&ast;","&para","&nbsp","&num;","&sup3","&sup2","&shy;","&uuml","&div;","&euml","&deg;","&macr","&REG;","&reg;","&Uuml","&not;","&ordf","&iuml","&eth;","&COPY","&copy","&Dot;","&cent","&die;","&uml;","&sect","&sol;","&QUOT","&yen;","&Tab;","&Hat;","&ETH","&pm;","&deg","&REG","&reg","&shy","&not","&uml","&yen","&GT;","&gt;","&LT;","&lt;","&AMP","&amp","&eth","&GT","&gt","&LT","&lt"],t.s)
B.lb=A.xq("I2")
B.LV=A.xq("Wy")
B.Vr=A.xq("oI")
B.mB=A.xq("mJ")
B.x9=A.xq("rF")
B.G3=A.xq("X6")
B.xg=A.xq("ZX")
B.h0=A.xq("a")
B.Ry=A.xq("HS")
B.zo=A.xq("Pz")
B.xU=A.xq("zt")
B.iY=A.xq("n6")})();(function staticFields(){$.zm=null
$.Qu=A.j([],t.f)
$.xu=null
$.i0=null
$.Hb=null
$.NF=null
$.TX=null
$.x7=null
$.nw=null
$.vv=null
$.Bv=null
$.Bi=A.j([],A.q7("p<zM<a>?>"))
$.j1=0})();(function lazyInitializers(){var s=hunkHelpers.lazyFinal
s($,"fa","w",()=>A.Yg("_$dart_dartClosure"))
s($,"hJ","u",()=>A.j([new J.B()],A.q7("p<rY>")))
s($,"mf","z4",()=>A.nu("^[\\-\\.0-9A-Z_a-z~]*$"))
s($,"Cc","Ob",()=>typeof URLSearchParams=="function")
s($,"X0","t8",()=>A.CU(B.h0))
s($,"Zj","Ww",()=>{var r=new A.lM()
r.U()
return r})})();(function nativeSupport(){!function(){var s=function(a){var m={}
m[a]=1
return Object.keys(hunkHelpers.convertToFastObject(m))[0]}
v.getIsolateTag=function(a){return s("___dart_"+a+v.isolateTag)}
var r="___dart_isolate_tags_"
var q=Object[r]||(Object[r]=Object.create(null))
var p="_ZxYxX"
for(var o=0;;o++){var n=s(p+"_"+o+"_")
if(!(n in q)){q[n]=1
v.isolateTag=n
break}}v.dispatchPropertyName=v.getIsolateTag("dispatch_record")}()
hunkHelpers.setOrUpdateInterceptorsByTag({ArrayBuffer:A.WZ,ArrayBufferView:A.eH,DataView:A.df,Float32Array:A.zU,Float64Array:A.K8,Int16Array:A.xj,Int32Array:A.dE,Int8Array:A.Zc,Uint16Array:A.wf,Uint32Array:A.Pq,Uint8ClampedArray:A.eE,CanvasPixelArray:A.eE,Uint8Array:A.V6})
hunkHelpers.setOrUpdateLeafTags({ArrayBuffer:true,ArrayBufferView:false,DataView:true,Float32Array:true,Float64Array:true,Int16Array:true,Int32Array:true,Int8Array:true,Uint16Array:true,Uint32Array:true,Uint8ClampedArray:true,CanvasPixelArray:true,Uint8Array:false})
A.b0.$nativeSuperclassTag="ArrayBufferView"
A.RG.$nativeSuperclassTag="ArrayBufferView"
A.vX.$nativeSuperclassTag="ArrayBufferView"
A.Dg.$nativeSuperclassTag="ArrayBufferView"
A.WB.$nativeSuperclassTag="ArrayBufferView"
A.VS.$nativeSuperclassTag="ArrayBufferView"
A.DV.$nativeSuperclassTag="ArrayBufferView"})()
Function.prototype.$0=function(){return this()}
Function.prototype.$1=function(a){return this(a)}
Function.prototype.$2=function(a,b){return this(a,b)}
Function.prototype.$1$1=function(a){return this(a)}
convertAllToFastObject(w)
convertToFastObject($);(function(a){if(typeof document==="undefined"){a(null)
return}if(typeof document.currentScript!="undefined"){a(document.currentScript)
return}var s=document.scripts
function onLoad(b){for(var q=0;q<s.length;++q){s[q].removeEventListener("load",onLoad,false)}a(b.target)}for(var r=0;r<s.length;++r){s[r].addEventListener("load",onLoad,false)}})(function(a){v.currentScript=a
var s=A.E2
if(typeof dartMainRunner==="function"){dartMainRunner(s,[])}else{s([])}})})()