//----------------------------------------------------------
// Copyright (C) Microsoft Corporation. All rights reserved.
//----------------------------------------------------------
// MicrosoftAjax.js
Function.__typeName="Function";Function.__class=true;Function.createCallback=function(b,a){return function(){var e=arguments.length;if(e>0){var d=[];for(var c=0;c<e;c++)d[c]=arguments[c];d[e]=a;return b.apply(this,d)}return b.call(this,a)}};Function.createDelegate=function(a,b){return function(){return b.apply(a,arguments)}};Function.emptyFunction=Function.emptyMethod=function(){};Function.validateParameters=function(c,b,a){return Function._validateParams(c,b,a)};Function._validateParams=function(g,e,c){var a,d=e.length;c=c||typeof c==="undefined";a=Function._validateParameterCount(g,e,c);if(a){a.popStackFrame();return a}for(var b=0,i=g.length;b<i;b++){var f=e[Math.min(b,d-1)],h=f.name;if(f.parameterArray)h+="["+(b-d+1)+"]";else if(!c&&b>=d)break;a=Function._validateParameter(g[b],f,h);if(a){a.popStackFrame();return a}}return null};Function._validateParameterCount=function(j,d,i){var a,c,b=d.length,e=j.length;if(e<b){var f=b;for(a=0;a<b;a++){var g=d[a];if(g.optional||g.parameterArray)f--}if(e<f)c=true}else if(i&&e>b){c=true;for(a=0;a<b;a++)if(d[a].parameterArray){c=false;break}}if(c){var h=Error.parameterCount();h.popStackFrame();return h}return null};Function._validateParameter=function(c,a,h){var b,g=a.type,l=!!a.integer,k=!!a.domElement,m=!!a.mayBeNull;b=Function._validateParameterType(c,g,l,k,m,h);if(b){b.popStackFrame();return b}var e=a.elementType,f=!!a.elementMayBeNull;if(g===Array&&typeof c!=="undefined"&&c!==null&&(e||!f)){var j=!!a.elementInteger,i=!!a.elementDomElement;for(var d=0;d<c.length;d++){var n=c[d];b=Function._validateParameterType(n,e,j,i,f,h+"["+d+"]");if(b){b.popStackFrame();return b}}}return null};Function._validateParameterType=function(b,c,k,j,h,d){var a,g;if(typeof b==="undefined")if(h)return null;else{a=Error.argumentUndefined(d);a.popStackFrame();return a}if(b===null)if(h)return null;else{a=Error.argumentNull(d);a.popStackFrame();return a}if(c&&c.__enum){if(typeof b!=="number"){a=Error.argumentType(d,Object.getType(b),c);a.popStackFrame();return a}if(b%1===0){var e=c.prototype;if(!c.__flags||b===0){for(g in e)if(e[g]===b)return null}else{var i=b;for(g in e){var f=e[g];if(f===0)continue;if((f&b)===f)i-=f;if(i===0)return null}}}a=Error.argumentOutOfRange(d,b,String.format(Sys.Res.enumInvalidValue,b,c.getName()));a.popStackFrame();return a}if(j&&(!Sys._isDomElement(b)||b.nodeType===3)){a=Error.argument(d,Sys.Res.argumentDomElement);a.popStackFrame();return a}if(c&&!Sys._isInstanceOfType(c,b)){a=Error.argumentType(d,Object.getType(b),c);a.popStackFrame();return a}if(c===Number&&k)if(b%1!==0){a=Error.argumentOutOfRange(d,b,Sys.Res.argumentInteger);a.popStackFrame();return a}return null};Error.__typeName="Error";Error.__class=true;Error.create=function(d,b){var a=new Error(d);a.message=d;if(b)for(var c in b)a[c]=b[c];a.popStackFrame();return a};Error.argument=function(a,c){var b="Sys.ArgumentException: "+(c?c:Sys.Res.argument);if(a)b+="\n"+String.format(Sys.Res.paramName,a);var d=Error.create(b,{name:"Sys.ArgumentException",paramName:a});d.popStackFrame();return d};Error.argumentNull=function(a,c){var b="Sys.ArgumentNullException: "+(c?c:Sys.Res.argumentNull);if(a)b+="\n"+String.format(Sys.Res.paramName,a);var d=Error.create(b,{name:"Sys.ArgumentNullException",paramName:a});d.popStackFrame();return d};Error.argumentOutOfRange=function(c,a,d){var b="Sys.ArgumentOutOfRangeException: "+(d?d:Sys.Res.argumentOutOfRange);if(c)b+="\n"+String.format(Sys.Res.paramName,c);if(typeof a!=="undefined"&&a!==null)b+="\n"+String.format(Sys.Res.actualValue,a);var e=Error.create(b,{name:"Sys.ArgumentOutOfRangeException",paramName:c,actualValue:a});e.popStackFrame();return e};Error.argumentType=function(d,c,b,e){var a="Sys.ArgumentTypeException: ";if(e)a+=e;else if(c&&b)a+=String.format(Sys.Res.argumentTypeWithTypes,c.getName(),b.getName());else a+=Sys.Res.argumentType;if(d)a+="\n"+String.format(Sys.Res.paramName,d);var f=Error.create(a,{name:"Sys.ArgumentTypeException",paramName:d,actualType:c,expectedType:b});f.popStackFrame();return f};Error.argumentUndefined=function(a,c){var b="Sys.ArgumentUndefinedException: "+(c?c:Sys.Res.argumentUndefined);if(a)b+="\n"+String.format(Sys.Res.paramName,a);var d=Error.create(b,{name:"Sys.ArgumentUndefinedException",paramName:a});d.popStackFrame();return d};Error.format=function(a){var c="Sys.FormatException: "+(a?a:Sys.Res.format),b=Error.create(c,{name:"Sys.FormatException"});b.popStackFrame();return b};Error.invalidOperation=function(a){var c="Sys.InvalidOperationException: "+(a?a:Sys.Res.invalidOperation),b=Error.create(c,{name:"Sys.InvalidOperationException"});b.popStackFrame();return b};Error.notImplemented=function(a){var c="Sys.NotImplementedException: "+(a?a:Sys.Res.notImplemented),b=Error.create(c,{name:"Sys.NotImplementedException"});b.popStackFrame();return b};Error.parameterCount=function(a){var c="Sys.ParameterCountException: "+(a?a:Sys.Res.parameterCount),b=Error.create(c,{name:"Sys.ParameterCountException"});b.popStackFrame();return b};Error.prototype.popStackFrame=function(){if(typeof this.stack==="undefined"||this.stack===null||typeof this.fileName==="undefined"||this.fileName===null||typeof this.lineNumber==="undefined"||this.lineNumber===null)return;var a=this.stack.split("\n"),c=a[0],e=this.fileName+":"+this.lineNumber;while(typeof c!=="undefined"&&c!==null&&c.indexOf(e)===-1){a.shift();c=a[0]}var d=a[1];if(typeof d==="undefined"||d===null)return;var b=d.match(/@(.*):(\d+)$/);if(typeof b==="undefined"||b===null)return;this.fileName=b[1];this.lineNumber=parseInt(b[2]);a.shift();this.stack=a.join("\n")};Object.__typeName="Object";Object.__class=true;Object.getType=function(b){var a=b.constructor;if(!a||typeof a!=="function"||!a.__typeName||a.__typeName==="Object")return Object;return a};Object.getTypeName=function(a){return Object.getType(a).getName()};String.__typeName="String";String.__class=true;String.prototype.endsWith=function(a){return this.substr(this.length-a.length)===a};String.prototype.startsWith=function(a){return this.substr(0,a.length)===a};String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")};String.prototype.trimEnd=function(){return this.replace(/\s+$/,"")};String.prototype.trimStart=function(){return this.replace(/^\s+/,"")};String.format=function(){return String._toFormattedString(false,arguments)};String._toFormattedString=function(l,j){var c="",e=j[0];for(var a=0;true;){var f=e.indexOf("{",a),d=e.indexOf("}",a);if(f<0&&d<0){c+=e.slice(a);break}if(d>0&&(d<f||f<0)){c+=e.slice(a,d+1);a=d+2;continue}c+=e.slice(a,f);a=f+1;if(e.charAt(a)==="{"){c+="{";a++;continue}if(d<0)break;var h=e.substring(a,d),g=h.indexOf(":"),k=parseInt(g<0?h:h.substring(0,g),10)+1,i=g<0?"":h.substring(g+1),b=j[k];if(typeof b==="undefined"||b===null)b="";if(b.toFormattedString)c+=b.toFormattedString(i);else if(l&&b.localeFormat)c+=b.localeFormat(i);else if(b.format)c+=b.format(i);else c+=b.toString();a=d+1}return c};Boolean.__typeName="Boolean";Boolean.__class=true;Boolean.parse=function(b){var a=b.trim().toLowerCase();if(a==="false")return false;if(a==="true")return true};Date.__typeName="Date";Date.__class=true;Number.__typeName="Number";Number.__class=true;RegExp.__typeName="RegExp";RegExp.__class=true;if(!window)this.window=this;window.Type=Function;Type.prototype.callBaseMethod=function(a,d,b){var c=Sys._getBaseMethod(this,a,d);if(!b)return c.apply(a);else return c.apply(a,b)};Type.prototype.getBaseMethod=function(a,b){return Sys._getBaseMethod(this,a,b)};Type.prototype.getBaseType=function(){return typeof this.__baseType==="undefined"?null:this.__baseType};Type.prototype.getInterfaces=function(){var a=[],b=this;while(b){var c=b.__interfaces;if(c)for(var d=0,f=c.length;d<f;d++){var e=c[d];if(!Array.contains(a,e))a[a.length]=e}b=b.__baseType}return a};Type.prototype.getName=function(){return typeof this.__typeName==="undefined"?"":this.__typeName};Type.prototype.implementsInterface=function(d){this.resolveInheritance();var c=d.getName(),a=this.__interfaceCache;if(a){var e=a[c];if(typeof e!=="undefined")return e}else a=this.__interfaceCache={};var b=this;while(b){var f=b.__interfaces;if(f)if(Array.indexOf(f,d)!==-1)return a[c]=true;b=b.__baseType}return a[c]=false};Type.prototype.inheritsFrom=function(b){this.resolveInheritance();var a=this.__baseType;while(a){if(a===b)return true;a=a.__baseType}return false};Type.prototype.initializeBase=function(a,b){this.resolveInheritance();if(this.__baseType)if(!b)this.__baseType.apply(a);else this.__baseType.apply(a,b);return a};Type.prototype.isImplementedBy=function(a){if(typeof a==="undefined"||a===null)return false;var b=Object.getType(a);return !!(b.implementsInterface&&b.implementsInterface(this))};Type.prototype.isInstanceOfType=function(a){return Sys._isInstanceOfType(this,a)};Type.prototype.registerClass=function(c,b,d){this.prototype.constructor=this;this.__typeName=c;this.__class=true;if(b){this.__baseType=b;this.__basePrototypePending=true}Sys.__upperCaseTypes[c.toUpperCase()]=this;if(d){this.__interfaces=[];for(var a=2,f=arguments.length;a<f;a++){var e=arguments[a];this.__interfaces.push(e)}}return this};Type.prototype.registerInterface=function(a){Sys.__upperCaseTypes[a.toUpperCase()]=this;this.prototype.constructor=this;this.__typeName=a;this.__interface=true;return this};Type.prototype.resolveInheritance=function(){if(this.__basePrototypePending){var b=this.__baseType;b.resolveInheritance();for(var a in b.prototype){var c=b.prototype[a];if(!this.prototype[a])this.prototype[a]=c}delete this.__basePrototypePending}};Type.getRootNamespaces=function(){return Array.clone(Sys.__rootNamespaces)};Type.isClass=function(a){if(typeof a==="undefined"||a===null)return false;return !!a.__class};Type.isInterface=function(a){if(typeof a==="undefined"||a===null)return false;return !!a.__interface};Type.isNamespace=function(a){if(typeof a==="undefined"||a===null)return false;return !!a.__namespace};Type.parse=function(typeName,ns){var fn;if(ns){fn=Sys.__upperCaseTypes[ns.getName().toUpperCase()+"."+typeName.toUpperCase()];return fn||null}if(!typeName)return null;if(!Type.__htClasses)Type.__htClasses={};fn=Type.__htClasses[typeName];if(!fn){fn=eval(typeName);Type.__htClasses[typeName]=fn}return fn};Type.registerNamespace=function(e){var d=window,c=e.split(".");for(var b=0;b<c.length;b++){var f=c[b],a=d[f];if(!a)a=d[f]={};if(!a.__namespace){if(b===0&&e!=="Sys")Sys.__rootNamespaces[Sys.__rootNamespaces.length]=a;a.__namespace=true;a.__typeName=c.slice(0,b+1).join(".");a.getName=function(){return this.__typeName}}d=a}};Type._checkDependency=function(c,a){var d=Type._registerScript._scripts,b=d?!!d[c]:false;if(typeof a!=="undefined"&&!b)throw Error.invalidOperation(String.format(Sys.Res.requiredScriptReferenceNotIncluded,a,c));return b};Type._registerScript=function(a,c){var b=Type._registerScript._scripts;if(!b)Type._registerScript._scripts=b={};if(b[a])throw Error.invalidOperation(String.format(Sys.Res.scriptAlreadyLoaded,a));b[a]=true;if(c)for(var d=0,f=c.length;d<f;d++){var e=c[d];if(!Type._checkDependency(e))throw Error.invalidOperation(String.format(Sys.Res.scriptDependencyNotFound,a,e))}};Type.registerNamespace("Sys");Sys.__upperCaseTypes={};Sys.__rootNamespaces=[Sys];Sys._isInstanceOfType=function(c,b){if(typeof b==="undefined"||b===null)return false;if(b instanceof c)return true;var a=Object.getType(b);return !!(a===c)||a.inheritsFrom&&a.inheritsFrom(c)||a.implementsInterface&&a.implementsInterface(c)};Sys._getBaseMethod=function(d,e,c){var b=d.getBaseType();if(b){var a=b.prototype[c];return a instanceof Function?a:null}return null};Sys._isDomElement=function(a){var c=false;if(typeof a.nodeType!=="number"){var b=a.ownerDocument||a.document||a;if(b!=a){var d=b.defaultView||b.parentWindow;c=d!=a}else c=typeof b.body==="undefined"}return !c};Array.__typeName="Array";Array.__class=true;Array.add=Array.enqueue=function(a,b){a[a.length]=b};Array.addRange=function(a,b){a.push.apply(a,b)};Array.clear=function(a){a.length=0};Array.clone=function(a){if(a.length===1)return [a[0]];else return Array.apply(null,a)};Array.contains=function(a,b){return Sys._indexOf(a,b)>=0};Array.dequeue=function(a){return a.shift()};Array.forEach=function(b,e,d){for(var a=0,f=b.length;a<f;a++){var c=b[a];if(typeof c!=="undefined")e.call(d,c,a,b)}};Array.indexOf=function(a,c,b){return Sys._indexOf(a,c,b)};Array.insert=function(a,b,c){a.splice(b,0,c)};Array.parse=function(value){if(!value)return [];return eval(value)};Array.remove=function(b,c){var a=Sys._indexOf(b,c);if(a>=0)b.splice(a,1);return a>=0};Array.removeAt=function(a,b){a.splice(b,1)};Sys._indexOf=function(d,e,a){if(typeof e==="undefined")return -1;var c=d.length;if(c!==0){a=a-0;if(isNaN(a))a=0;else{if(isFinite(a))a=a-a%1;if(a<0)a=Math.max(0,c+a)}for(var b=a;b<c;b++)if(typeof d[b]!=="undefined"&&d[b]===e)return b}return -1};Type._registerScript._scripts={"MicrosoftAjaxCore.js":true,"MicrosoftAjaxGlobalization.js":true,"MicrosoftAjaxSerialization.js":true,"MicrosoftAjaxComponentModel.js":true,"MicrosoftAjaxHistory.js":true,"MicrosoftAjaxNetwork.js":true,"MicrosoftAjaxWebServices.js":true};Sys.IDisposable=function(){};Sys.IDisposable.prototype={};Sys.IDisposable.registerInterface("Sys.IDisposable");Sys.StringBuilder=function(a){this._parts=typeof a!=="undefined"&&a!==null&&a!==""?[a.toString()]:[];this._value={};this._len=0};Sys.StringBuilder.prototype={append:function(a){this._parts[this._parts.length]=a},appendLine:function(a){this._parts[this._parts.length]=typeof a==="undefined"||a===null||a===""?"\r\n":a+"\r\n"},clear:function(){this._parts=[];this._value={};this._len=0},isEmpty:function(){if(this._parts.length===0)return true;return this.toString()===""},toString:function(a){a=a||"";var b=this._parts;if(this._len!==b.length){this._value={};this._len=b.length}var d=this._value;if(typeof d[a]==="undefined"){if(a!=="")for(var c=0;c<b.length;)if(typeof b[c]==="undefined"||b[c]===""||b[c]===null)b.splice(c,1);else c++;d[a]=this._parts.join(a)}return d[a]}};Sys.StringBuilder.registerClass("Sys.StringBuilder");Sys.Browser={};Sys.Browser.InternetExplorer={};Sys.Browser.Firefox={};Sys.Browser.Safari={};Sys.Browser.Opera={};Sys.Browser.agent=null;Sys.Browser.hasDebuggerStatement=false;Sys.Browser.name=navigator.appName;Sys.Browser.version=parseFloat(navigator.appVersion);Sys.Browser.documentMode=0;if(navigator.userAgent.indexOf(" MSIE ")>-1){Sys.Browser.agent=Sys.Browser.InternetExplorer;Sys.Browser.version=parseFloat(navigator.userAgent.match(/MSIE (\d+\.\d+)/)[1]);if(Sys.Browser.version>=8)if(document.documentMode>=7)Sys.Browser.documentMode=document.documentMode;Sys.Browser.hasDebuggerStatement=true}else if(navigator.userAgent.indexOf(" Firefox/")>-1){Sys.Browser.agent=Sys.Browser.Firefox;Sys.Browser.version=parseFloat(navigator.userAgent.match(/Firefox\/(\d+\.\d+)/)[1]);Sys.Browser.name="Firefox";Sys.Browser.hasDebuggerStatement=true}else if(navigator.userAgent.indexOf(" AppleWebKit/")>-1){Sys.Browser.agent=Sys.Browser.Safari;Sys.Browser.version=parseFloat(navigator.userAgent.match(/AppleWebKit\/(\d+(\.\d+)?)/)[1]);Sys.Browser.name="Safari"}else if(navigator.userAgent.indexOf("Opera/")>-1)Sys.Browser.agent=Sys.Browser.Opera;Sys.EventArgs=function(){};Sys.EventArgs.registerClass("Sys.EventArgs");Sys.EventArgs.Empty=new Sys.EventArgs;Sys.CancelEventArgs=function(){Sys.CancelEventArgs.initializeBase(this);this._cancel=false};Sys.CancelEventArgs.prototype={get_cancel:function(){return this._cancel},set_cancel:function(a){this._cancel=a}};Sys.CancelEventArgs.registerClass("Sys.CancelEventArgs",Sys.EventArgs);Type.registerNamespace("Sys.UI");Sys._Debug=function(){};Sys._Debug.prototype={_appendConsole:function(a){if(typeof Debug!=="undefined"&&Debug.writeln)Debug.writeln(a);if(window.console&&window.console.log)window.console.log(a);if(window.opera)window.opera.postError(a);if(window.debugService)window.debugService.trace(a)},_appendTrace:function(b){var a=document.getElementById("TraceConsole");if(a&&a.tagName.toUpperCase()==="TEXTAREA")a.value+=b+"\n"},assert:function(c,a,b){if(!c){a=b&&this.assert.caller?String.format(Sys.Res.assertFailedCaller,a,this.assert.caller):String.format(Sys.Res.assertFailed,a);if(confirm(String.format(Sys.Res.breakIntoDebugger,a)))this.fail(a)}},clearTrace:function(){var a=document.getElementById("TraceConsole");if(a&&a.tagName.toUpperCase()==="TEXTAREA")a.value=""},fail:function(message){this._appendConsole(message);if(Sys.Browser.hasDebuggerStatement)eval("debugger")},trace:function(a){this._appendConsole(a);this._appendTrace(a)},traceDump:function(a,b){var c=this._traceDump(a,b,true)},_traceDump:function(a,c,f,b,d){c=c?c:"traceDump";b=b?b:"";if(a===null){this.trace(b+c+": null");return}switch(typeof a){case "undefined":this.trace(b+c+": Undefined");break;case "number":case "string":case "boolean":this.trace(b+c+": "+a);break;default:if(Date.isInstanceOfType(a)||RegExp.isInstanceOfType(a)){this.trace(b+c+": "+a.toString());break}if(!d)d=[];else if(Array.contains(d,a)){this.trace(b+c+": ...");return}Array.add(d,a);if(a==window||a===document||window.HTMLElement&&a instanceof HTMLElement||typeof a.nodeName==="string"){var k=a.tagName?a.tagName:"DomElement";if(a.id)k+=" - "+a.id;this.trace(b+c+" {"+k+"}")}else{var i=Object.getTypeName(a);this.trace(b+c+(typeof i==="string"?" {"+i+"}":""));if(b===""||f){b+="    ";var e,j,l,g,h;if(Array.isInstanceOfType(a)){j=a.length;for(e=0;e<j;e++)this._traceDump(a[e],"["+e+"]",f,b,d)}else for(g in a){h=a[g];if(!Function.isInstanceOfType(h))this._traceDump(h,g,f,b,d)}}}Array.remove(d,a)}}};Sys._Debug.registerClass("Sys._Debug");Sys.Debug=new Sys._Debug;Sys.Debug.isDebug=false;function Sys$Enum$parse(c,e){var a,b,i;if(e){a=this.__lowerCaseValues;if(!a){this.__lowerCaseValues=a={};var g=this.prototype;for(var f in g)a[f.toLowerCase()]=g[f]}}else a=this.prototype;if(!this.__flags){i=e?c.toLowerCase():c;b=a[i.trim()];if(typeof b!=="number")throw Error.argument("value",String.format(Sys.Res.enumInvalidValue,c,this.__typeName));return b}else{var h=(e?c.toLowerCase():c).split(","),j=0;for(var d=h.length-1;d>=0;d--){var k=h[d].trim();b=a[k];if(typeof b!=="number")throw Error.argument("value",String.format(Sys.Res.enumInvalidValue,c.split(",")[d].trim(),this.__typeName));j|=b}return j}}function Sys$Enum$toString(c){if(typeof c==="undefined"||c===null)return this.__string;var d=this.prototype,a;if(!this.__flags||c===0){for(a in d)if(d[a]===c)return a}else{var b=this.__sortedValues;if(!b){b=[];for(a in d)b[b.length]={key:a,value:d[a]};b.sort(function(a,b){return a.value-b.value});this.__sortedValues=b}var e=[],g=c;for(a=b.length-1;a>=0;a--){var h=b[a],f=h.value;if(f===0)continue;if((f&c)===f){e[e.length]=h.key;g-=f;if(g===0)break}}if(e.length&&g===0)return e.reverse().join(", ")}return ""}Type.prototype.registerEnum=function(b,c){Sys.__upperCaseTypes[b.toUpperCase()]=this;for(var a in this.prototype)this[a]=this.prototype[a];this.__typeName=b;this.parse=Sys$Enum$parse;this.__string=this.toString();this.toString=Sys$Enum$toString;this.__flags=c;this.__enum=true};Type.isEnum=function(a){if(typeof a==="undefined"||a===null)return false;return !!a.__enum};Type.isFlags=function(a){if(typeof a==="undefined"||a===null)return false;return !!a.__flags};Sys.CollectionChange=function(e,a,c,b,d){this.action=e;if(a)if(!(a instanceof Array))a=[a];this.newItems=a||null;if(typeof c!=="number")c=-1;this.newStartingIndex=c;if(b)if(!(b instanceof Array))b=[b];this.oldItems=b||null;if(typeof d!=="number")d=-1;this.oldStartingIndex=d};Sys.CollectionChange.registerClass("Sys.CollectionChange");Sys.NotifyCollectionChangedAction=function(){throw Error.notImplemented()};Sys.NotifyCollectionChangedAction.prototype={add:0,remove:1,reset:2};Sys.NotifyCollectionChangedAction.registerEnum("Sys.NotifyCollectionChangedAction");Sys.NotifyCollectionChangedEventArgs=function(a){this._changes=a;Sys.NotifyCollectionChangedEventArgs.initializeBase(this)};Sys.NotifyCollectionChangedEventArgs.prototype={get_changes:function(){return this._changes||[]}};Sys.NotifyCollectionChangedEventArgs.registerClass("Sys.NotifyCollectionChangedEventArgs",Sys.EventArgs);Sys.Observer=function(){};Sys.Observer.registerClass("Sys.Observer");Sys.Observer.makeObservable=function(a){var c=a instanceof Array,b=Sys.Observer;if(a.setValue===b._observeMethods.setValue)return a;b._addMethods(a,b._observeMethods);if(c)b._addMethods(a,b._arrayMethods);return a};Sys.Observer._addMethods=function(c,b){for(var a in b)c[a]=b[a]};Sys.Observer._addEventHandler=function(c,a,b){Sys.Observer._getContext(c,true).events._addHandler(a,b)};Sys.Observer.addEventHandler=function(c,a,b){Sys.Observer._addEventHandler(c,a,b)};Sys.Observer._removeEventHandler=function(c,a,b){Sys.Observer._getContext(c,true).events._removeHandler(a,b)};Sys.Observer.removeEventHandler=function(c,a,b){Sys.Observer._removeEventHandler(c,a,b)};Sys.Observer.raiseEvent=function(b,e,d){var c=Sys.Observer._getContext(b);if(!c)return;var a=c.events.getHandler(e);if(a)a(b,d)};Sys.Observer.addPropertyChanged=function(b,a){Sys.Observer._addEventHandler(b,"propertyChanged",a)};Sys.Observer.removePropertyChanged=function(b,a){Sys.Observer._removeEventHandler(b,"propertyChanged",a)};Sys.Observer.beginUpdate=function(a){Sys.Observer._getContext(a,true).updating=true};Sys.Observer.endUpdate=function(b){var a=Sys.Observer._getContext(b);if(!a||!a.updating)return;a.updating=false;var d=a.dirty;a.dirty=false;if(d){if(b instanceof Array){var c=a.changes;a.changes=null;Sys.Observer.raiseCollectionChanged(b,c)}Sys.Observer.raisePropertyChanged(b,"")}};Sys.Observer.isUpdating=function(b){var a=Sys.Observer._getContext(b);return a?a.updating:false};Sys.Observer._setValue=function(a,j,g){var b,f,k=a,d=j.split(".");for(var i=0,m=d.length-1;i<m;i++){var l=d[i];b=a["get_"+l];if(typeof b==="function")a=b.call(a);else a=a[l];var n=typeof a;if(a===null||n==="undefined")throw Error.invalidOperation(String.format(Sys.Res.nullReferenceInPath,j))}var e,c=d[m];b=a["get_"+c];f=a["set_"+c];if(typeof b==="function")e=b.call(a);else e=a[c];if(typeof f==="function")f.call(a,g);else a[c]=g;if(e!==g){var h=Sys.Observer._getContext(k);if(h&&h.updating){h.dirty=true;return}Sys.Observer.raisePropertyChanged(k,d[0])}};Sys.Observer.setValue=function(b,a,c){Sys.Observer._setValue(b,a,c)};Sys.Observer.raisePropertyChanged=function(b,a){Sys.Observer.raiseEvent(b,"propertyChanged",new Sys.PropertyChangedEventArgs(a))};Sys.Observer.addCollectionChanged=function(b,a){Sys.Observer._addEventHandler(b,"collectionChanged",a)};Sys.Observer.removeCollectionChanged=function(b,a){Sys.Observer._removeEventHandler(b,"collectionChanged",a)};Sys.Observer._collectionChange=function(d,c){var a=Sys.Observer._getContext(d);if(a&&a.updating){a.dirty=true;var b=a.changes;if(!b)a.changes=b=[c];else b.push(c)}else{Sys.Observer.raiseCollectionChanged(d,[c]);Sys.Observer.raisePropertyChanged(d,"length")}};Sys.Observer.add=function(a,b){var c=new Sys.CollectionChange(Sys.NotifyCollectionChangedAction.add,[b],a.length);Array.add(a,b);Sys.Observer._collectionChange(a,c)};Sys.Observer.addRange=function(a,b){var c=new Sys.CollectionChange(Sys.NotifyCollectionChangedAction.add,b,a.length);Array.addRange(a,b);Sys.Observer._collectionChange(a,c)};Sys.Observer.clear=function(a){var b=Array.clone(a);Array.clear(a);Sys.Observer._collectionChange(a,new Sys.CollectionChange(Sys.NotifyCollectionChangedAction.reset,null,-1,b,0))};Sys.Observer.insert=function(a,b,c){Array.insert(a,b,c);Sys.Observer._collectionChange(a,new Sys.CollectionChange(Sys.NotifyCollectionChangedAction.add,[c],b))};Sys.Observer.remove=function(a,b){var c=Array.indexOf(a,b);if(c!==-1){Array.remove(a,b);Sys.Observer._collectionChange(a,new Sys.CollectionChange(Sys.NotifyCollectionChangedAction.remove,null,-1,[b],c));return true}return false};Sys.Observer.removeAt=function(b,a){if(a>-1&&a<b.length){var c=b[a];Array.removeAt(b,a);Sys.Observer._collectionChange(b,new Sys.CollectionChange(Sys.NotifyCollectionChangedAction.remove,null,-1,[c],a))}};Sys.Observer.raiseCollectionChanged=function(b,a){Sys.Observer.raiseEvent(b,"collectionChanged",new Sys.NotifyCollectionChangedEventArgs(a))};Sys.Observer._observeMethods={add_propertyChanged:function(a){Sys.Observer._addEventHandler(this,"propertyChanged",a)},remove_propertyChanged:function(a){Sys.Observer._removeEventHandler(this,"propertyChanged",a)},addEventHandler:function(a,b){Sys.Observer._addEventHandler(this,a,b)},removeEventHandler:function(a,b){Sys.Observer._removeEventHandler(this,a,b)},get_isUpdating:function(){return Sys.Observer.isUpdating(this)},beginUpdate:function(){Sys.Observer.beginUpdate(this)},endUpdate:function(){Sys.Observer.endUpdate(this)},setValue:function(b,a){Sys.Observer._setValue(this,b,a)},raiseEvent:function(b,a){Sys.Observer.raiseEvent(this,b,a)},raisePropertyChanged:function(a){Sys.Observer.raiseEvent(this,"propertyChanged",new Sys.PropertyChangedEventArgs(a))}};Sys.Observer._arrayMethods={add_collectionChanged:function(a){Sys.Observer._addEventHandler(this,"collectionChanged",a)},remove_collectionChanged:function(a){Sys.Observer._removeEventHandler(this,"collectionChanged",a)},add:function(a){Sys.Observer.add(this,a)},addRange:function(a){Sys.Observer.addRange(this,a)},clear:function(){Sys.Observer.clear(this)},insert:function(a,b){Sys.Observer.insert(this,a,b)},remove:function(a){return Sys.Observer.remove(this,a)},removeAt:function(a){Sys.Observer.removeAt(this,a)},raiseCollectionChanged:function(a){Sys.Observer.raiseEvent(this,"collectionChanged",new Sys.NotifyCollectionChangedEventArgs(a))}};Sys.Observer._getContext=function(b,c){var a=b._observerContext;if(a)return a();if(c)return (b._observerContext=Sys.Observer._createContext())();return null};Sys.Observer._createContext=function(){var a={events:new Sys.EventHandlerList};return function(){return a}};Date._appendPreOrPostMatch=function(e,b){var d=0,a=false;for(var c=0,g=e.length;c<g;c++){var f=e.charAt(c);switch(f){case "'":if(a)b.append("'");else d++;a=false;break;case "\\":if(a)b.append("\\");a=!a;break;default:b.append(f);a=false}}return d};Date._expandFormat=function(a,b){if(!b)b="F";var c=b.length;if(c===1)switch(b){case "d":return a.ShortDatePattern;case "D":return a.LongDatePattern;case "t":return a.ShortTimePattern;case "T":return a.LongTimePattern;case "f":return a.LongDatePattern+" "+a.ShortTimePattern;case "F":return a.FullDateTimePattern;case "M":case "m":return a.MonthDayPattern;case "s":return a.SortableDateTimePattern;case "Y":case "y":return a.YearMonthPattern;default:throw Error.format(Sys.Res.formatInvalidString)}else if(c===2&&b.charAt(0)==="%")b=b.charAt(1);return b};Date._expandYear=function(c,a){var d=new Date,e=Date._getEra(d);if(a<100){var b=Date._getEraYear(d,c,e);a+=b-b%100;if(a>c.Calendar.TwoDigitYearMax)a-=100}return a};Date._getEra=function(e,c){if(!c)return 0;var b,d=e.getTime();for(var a=0,f=c.length;a<f;a+=4){b=c[a+2];if(b===null||d>=b)return a}return 0};Date._getEraYear=function(d,b,e,c){var a=d.getFullYear();if(!c&&b.eras)a-=b.eras[e+3];return a};Date._getParseRegExp=function(b,e){if(!b._parseRegExp)b._parseRegExp={};else if(b._parseRegExp[e])return b._parseRegExp[e];var c=Date._expandFormat(b,e);c=c.replace(/([\^\$\.\*\+\?\|\[\]\(\)\{\}])/g,"\\\\$1");var a=new Sys.StringBuilder("^"),j=[],f=0,i=0,h=Date._getTokenRegExp(),d;while((d=h.exec(c))!==null){var l=c.slice(f,d.index);f=h.lastIndex;i+=Date._appendPreOrPostMatch(l,a);if(i%2===1){a.append(d[0]);continue}switch(d[0]){case "dddd":case "ddd":case "MMMM":case "MMM":case "gg":case "g":a.append("(\\D+)");break;case "tt":case "t":a.append("(\\D*)");break;case "yyyy":a.append("(\\d{4})");break;case "fff":a.append("(\\d{3})");break;case "ff":a.append("(\\d{2})");break;case "f":a.append("(\\d)");break;case "dd":case "d":case "MM":case "M":case "yy":case "y":case "HH":case "H":case "hh":case "h":case "mm":case "m":case "ss":case "s":a.append("(\\d\\d?)");break;case "zzz":a.append("([+-]?\\d\\d?:\\d{2})");break;case "zz":case "z":a.append("([+-]?\\d\\d?)");break;case "/":a.append("(\\"+b.DateSeparator+")")}Array.add(j,d[0])}Date._appendPreOrPostMatch(c.slice(f),a);a.append("$");var k=a.toString().replace(/\s+/g,"\\s+"),g={"regExp":k,"groups":j};b._parseRegExp[e]=g;return g};Date._getTokenRegExp=function(){return /\/|dddd|ddd|dd|d|MMMM|MMM|MM|M|yyyy|yy|y|hh|h|HH|H|mm|m|ss|s|tt|t|fff|ff|f|zzz|zz|z|gg|g/g};Date.parseLocale=function(a){return Date._parse(a,Sys.CultureInfo.CurrentCulture,arguments)};Date.parseInvariant=function(a){return Date._parse(a,Sys.CultureInfo.InvariantCulture,arguments)};Date._parse=function(h,d,i){var a,c,b,f,e,g=false;for(a=1,c=i.length;a<c;a++){f=i[a];if(f){g=true;b=Date._parseExact(h,f,d);if(b)return b}}if(!g){e=d._getDateTimeFormats();for(a=0,c=e.length;a<c;a++){b=Date._parseExact(h,e[a],d);if(b)return b}}return null};Date._parseExact=function(w,D,k){w=w.trim();var g=k.dateTimeFormat,A=Date._getParseRegExp(g,D),C=(new RegExp(A.regExp)).exec(w);if(C===null)return null;var B=A.groups,x=null,e=null,c=null,j=null,i=null,d=0,h,p=0,q=0,f=0,l=null,v=false;for(var s=0,E=B.length;s<E;s++){var a=C[s+1];if(a)switch(B[s]){case "dd":case "d":j=parseInt(a,10);if(j<1||j>31)return null;break;case "MMMM":c=k._getMonthIndex(a);if(c<0||c>11)return null;break;case "MMM":c=k._getAbbrMonthIndex(a);if(c<0||c>11)return null;break;case "M":case "MM":c=parseInt(a,10)-1;if(c<0||c>11)return null;break;case "y":case "yy":e=Date._expandYear(g,parseInt(a,10));if(e<0||e>9999)return null;break;case "yyyy":e=parseInt(a,10);if(e<0||e>9999)return null;break;case "h":case "hh":d=parseInt(a,10);if(d===12)d=0;if(d<0||d>11)return null;break;case "H":case "HH":d=parseInt(a,10);if(d<0||d>23)return null;break;case "m":case "mm":p=parseInt(a,10);if(p<0||p>59)return null;break;case "s":case "ss":q=parseInt(a,10);if(q<0||q>59)return null;break;case "tt":case "t":var z=a.toUpperCase();v=z===g.PMDesignator.toUpperCase();if(!v&&z!==g.AMDesignator.toUpperCase())return null;break;case "f":f=parseInt(a,10)*100;if(f<0||f>999)return null;break;case "ff":f=parseInt(a,10)*10;if(f<0||f>999)return null;break;case "fff":f=parseInt(a,10);if(f<0||f>999)return null;break;case "dddd":i=k._getDayIndex(a);if(i<0||i>6)return null;break;case "ddd":i=k._getAbbrDayIndex(a);if(i<0||i>6)return null;break;case "zzz":var u=a.split(/:/);if(u.length!==2)return null;h=parseInt(u[0],10);if(h<-12||h>13)return null;var m=parseInt(u[1],10);if(m<0||m>59)return null;l=h*60+(a.startsWith("-")?-m:m);break;case "z":case "zz":h=parseInt(a,10);if(h<-12||h>13)return null;l=h*60;break;case "g":case "gg":var o=a;if(!o||!g.eras)return null;o=o.toLowerCase().trim();for(var r=0,F=g.eras.length;r<F;r+=4)if(o===g.eras[r+1].toLowerCase()){x=r;break}if(x===null)return null}}var b=new Date,t,n=g.Calendar.convert;if(n)t=n.fromGregorian(b)[0];else t=b.getFullYear();if(e===null)e=t;else if(g.eras)e+=g.eras[(x||0)+3];if(c===null)c=0;if(j===null)j=1;if(n){b=n.toGregorian(e,c,j);if(b===null)return null}else{b.setFullYear(e,c,j);if(b.getDate()!==j)return null;if(i!==null&&b.getDay()!==i)return null}if(v&&d<12)d+=12;b.setHours(d,p,q,f);if(l!==null){var y=b.getMinutes()-(l+b.getTimezoneOffset());b.setHours(b.getHours()+parseInt(y/60,10),y%60)}return b};Date.prototype.format=function(a){return this._toFormattedString(a,Sys.CultureInfo.InvariantCulture)};Date.prototype.localeFormat=function(a){return this._toFormattedString(a,Sys.CultureInfo.CurrentCulture)};Date.prototype._toFormattedString=function(e,j){var b=j.dateTimeFormat,n=b.Calendar.convert;if(!e||!e.length||e==="i")if(j&&j.name.length)if(n)return this._toFormattedString(b.FullDateTimePattern,j);else{var r=new Date(this.getTime()),x=Date._getEra(this,b.eras);r.setFullYear(Date._getEraYear(this,b,x));return r.toLocaleString()}else return this.toString();var l=b.eras,k=e==="s";e=Date._expandFormat(b,e);var a=new Sys.StringBuilder,c;function d(a){if(a<10)return "0"+a;return a.toString()}function m(a){if(a<10)return "00"+a;if(a<100)return "0"+a;return a.toString()}function v(a){if(a<10)return "000"+a;else if(a<100)return "00"+a;else if(a<1000)return "0"+a;return a.toString()}var h,p,t=/([^d]|^)(d|dd)([^d]|$)/g;function s(){if(h||p)return h;h=t.test(e);p=true;return h}var q=0,o=Date._getTokenRegExp(),f;if(!k&&n)f=n.fromGregorian(this);for(;true;){var w=o.lastIndex,i=o.exec(e),u=e.slice(w,i?i.index:e.length);q+=Date._appendPreOrPostMatch(u,a);if(!i)break;if(q%2===1){a.append(i[0]);continue}function g(a,b){if(f)return f[b];switch(b){case 0:return a.getFullYear();case 1:return a.getMonth();case 2:return a.getDate()}}switch(i[0]){case "dddd":a.append(b.DayNames[this.getDay()]);break;case "ddd":a.append(b.AbbreviatedDayNames[this.getDay()]);break;case "dd":h=true;a.append(d(g(this,2)));break;case "d":h=true;a.append(g(this,2));break;case "MMMM":a.append(b.MonthGenitiveNames&&s()?b.MonthGenitiveNames[g(this,1)]:b.MonthNames[g(this,1)]);break;case "MMM":a.append(b.AbbreviatedMonthGenitiveNames&&s()?b.AbbreviatedMonthGenitiveNames[g(this,1)]:b.AbbreviatedMonthNames[g(this,1)]);break;case "MM":a.append(d(g(this,1)+1));break;case "M":a.append(g(this,1)+1);break;case "yyyy":a.append(v(f?f[0]:Date._getEraYear(this,b,Date._getEra(this,l),k)));break;case "yy":a.append(d((f?f[0]:Date._getEraYear(this,b,Date._getEra(this,l),k))%100));break;case "y":a.append((f?f[0]:Date._getEraYear(this,b,Date._getEra(this,l),k))%100);break;case "hh":c=this.getHours()%12;if(c===0)c=12;a.append(d(c));break;case "h":c=this.getHours()%12;if(c===0)c=12;a.append(c);break;case "HH":a.append(d(this.getHours()));break;case "H":a.append(this.getHours());break;case "mm":a.append(d(this.getMinutes()));break;case "m":a.append(this.getMinutes());break;case "ss":a.append(d(this.getSeconds()));break;case "s":a.append(this.getSeconds());break;case "tt":a.append(this.getHours()<12?b.AMDesignator:b.PMDesignator);break;case "t":a.append((this.getHours()<12?b.AMDesignator:b.PMDesignator).charAt(0));break;case "f":a.append(m(this.getMilliseconds()).charAt(0));break;case "ff":a.append(m(this.getMilliseconds()).substr(0,2));break;case "fff":a.append(m(this.getMilliseconds()));break;case "z":c=this.getTimezoneOffset()/60;a.append((c<=0?"+":"-")+Math.floor(Math.abs(c)));break;case "zz":c=this.getTimezoneOffset()/60;a.append((c<=0?"+":"-")+d(Math.floor(Math.abs(c))));break;case "zzz":c=this.getTimezoneOffset()/60;a.append((c<=0?"+":"-")+d(Math.floor(Math.abs(c)))+":"+d(Math.abs(this.getTimezoneOffset()%60)));break;case "g":case "gg":if(b.eras)a.append(b.eras[Date._getEra(this,l)+1]);break;case "/":a.append(b.DateSeparator)}}return a.toString()};String.localeFormat=function(){return String._toFormattedString(true,arguments)};Number.parseLocale=function(a){return Number._parse(a,Sys.CultureInfo.CurrentCulture)};Number.parseInvariant=function(a){return Number._parse(a,Sys.CultureInfo.InvariantCulture)};Number._parse=function(b,o){b=b.trim();if(b.match(/^[+-]?infinity$/i))return parseFloat(b);if(b.match(/^0x[a-f0-9]+$/i))return parseInt(b);var a=o.numberFormat,g=Number._parseNumberNegativePattern(b,a,a.NumberNegativePattern),h=g[0],e=g[1];if(h===""&&a.NumberNegativePattern!==1){g=Number._parseNumberNegativePattern(b,a,1);h=g[0];e=g[1]}if(h==="")h="+";var j,d,f=e.indexOf("e");if(f<0)f=e.indexOf("E");if(f<0){d=e;j=null}else{d=e.substr(0,f);j=e.substr(f+1)}var c,k,m=d.indexOf(a.NumberDecimalSeparator);if(m<0){c=d;k=null}else{c=d.substr(0,m);k=d.substr(m+a.NumberDecimalSeparator.length)}c=c.split(a.NumberGroupSeparator).join("");var n=a.NumberGroupSeparator.replace(/\u00A0/g," ");if(a.NumberGroupSeparator!==n)c=c.split(n).join("");var l=h+c;if(k!==null)l+="."+k;if(j!==null){var i=Number._parseNumberNegativePattern(j,a,1);if(i[0]==="")i[0]="+";l+="e"+i[0]+i[1]}if(l.match(/^[+-]?\d*\.?\d*(e[+-]?\d+)?$/))return parseFloat(l);return Number.NaN};Number._parseNumberNegativePattern=function(a,d,e){var b=d.NegativeSign,c=d.PositiveSign;switch(e){case 4:b=" "+b;c=" "+c;case 3:if(a.endsWith(b))return ["-",a.substr(0,a.length-b.length)];else if(a.endsWith(c))return ["+",a.substr(0,a.length-c.length)];break;case 2:b+=" ";c+=" ";case 1:if(a.startsWith(b))return ["-",a.substr(b.length)];else if(a.startsWith(c))return ["+",a.substr(c.length)];break;case 0:if(a.startsWith("(")&&a.endsWith(")"))return ["-",a.substr(1,a.length-2)]}return ["",a]};Number.prototype.format=function(a){return this._toFormattedString(a,Sys.CultureInfo.InvariantCulture)};Number.prototype.localeFormat=function(a){return this._toFormattedString(a,Sys.CultureInfo.CurrentCulture)};Number.prototype._toFormattedString=function(e,j){if(!e||e.length===0||e==="i")if(j&&j.name.length>0)return this.toLocaleString();else return this.toString();var o=["n %","n%","%n"],n=["-n %","-n%","-%n"],p=["(n)","-n","- n","n-","n -"],m=["$n","n$","$ n","n $"],l=["($n)","-$n","$-n","$n-","(n$)","-n$","n-$","n$-","-n $","-$ n","n $-","$ n-","$ -n","n- $","($ n)","(n $)"];function g(a,c,d){for(var b=a.length;b<c;b++)a=d?"0"+a:a+"0";return a}function i(j,i,l,n,p){var h=l[0],k=1,o=Math.pow(10,i),m=Math.round(j*o)/o;if(!isFinite(m))m=j;j=m;var b=j.toString(),a="",c,e=b.split(/e/i);b=e[0];c=e.length>1?parseInt(e[1]):0;e=b.split(".");b=e[0];a=e.length>1?e[1]:"";var q;if(c>0){a=g(a,c,false);b+=a.slice(0,c);a=a.substr(c)}else if(c<0){c=-c;b=g(b,c+1,true);a=b.slice(-c,b.length)+a;b=b.slice(0,-c)}if(i>0){if(a.length>i)a=a.slice(0,i);else a=g(a,i,false);a=p+a}else a="";var d=b.length-1,f="";while(d>=0){if(h===0||h>d)if(f.length>0)return b.slice(0,d+1)+n+f+a;else return b.slice(0,d+1)+a;if(f.length>0)f=b.slice(d-h+1,d+1)+n+f;else f=b.slice(d-h+1,d+1);d-=h;if(k<l.length){h=l[k];k++}}return b.slice(0,d+1)+n+f+a}var a=j.numberFormat,d=Math.abs(this);if(!e)e="D";var b=-1;if(e.length>1)b=parseInt(e.slice(1),10);var c;switch(e.charAt(0)){case "d":case "D":c="n";if(b!==-1)d=g(""+d,b,true);if(this<0)d=-d;break;case "c":case "C":if(this<0)c=l[a.CurrencyNegativePattern];else c=m[a.CurrencyPositivePattern];if(b===-1)b=a.CurrencyDecimalDigits;d=i(Math.abs(this),b,a.CurrencyGroupSizes,a.CurrencyGroupSeparator,a.CurrencyDecimalSeparator);break;case "n":case "N":if(this<0)c=p[a.NumberNegativePattern];else c="n";if(b===-1)b=a.NumberDecimalDigits;d=i(Math.abs(this),b,a.NumberGroupSizes,a.NumberGroupSeparator,a.NumberDecimalSeparator);break;case "p":case "P":if(this<0)c=n[a.PercentNegativePattern];else c=o[a.PercentPositivePattern];if(b===-1)b=a.PercentDecimalDigits;d=i(Math.abs(this)*100,b,a.PercentGroupSizes,a.PercentGroupSeparator,a.PercentDecimalSeparator);break;default:throw Error.format(Sys.Res.formatBadFormatSpecifier)}var k=/n|\$|-|%/g,f="";for(;true;){var q=k.lastIndex,h=k.exec(c);f+=c.slice(q,h?h.index:c.length);if(!h)break;switch(h[0]){case "n":f+=d;break;case "$":f+=a.CurrencySymbol;break;case "-":if(/[1-9]/.test(d))f+=a.NegativeSign;break;case "%":f+=a.PercentSymbol}}return f};Sys.CultureInfo=function(c,b,a){this.name=c;this.numberFormat=b;this.dateTimeFormat=a};Sys.CultureInfo.prototype={_getDateTimeFormats:function(){if(!this._dateTimeFormats){var a=this.dateTimeFormat;this._dateTimeFormats=[a.MonthDayPattern,a.YearMonthPattern,a.ShortDatePattern,a.ShortTimePattern,a.LongDatePattern,a.LongTimePattern,a.FullDateTimePattern,a.RFC1123Pattern,a.SortableDateTimePattern,a.UniversalSortableDateTimePattern]}return this._dateTimeFormats},_getIndex:function(c,d,e){var b=this._toUpper(c),a=Array.indexOf(d,b);if(a===-1)a=Array.indexOf(e,b);return a},_getMonthIndex:function(a){if(!this._upperMonths){this._upperMonths=this._toUpperArray(this.dateTimeFormat.MonthNames);this._upperMonthsGenitive=this._toUpperArray(this.dateTimeFormat.MonthGenitiveNames)}return this._getIndex(a,this._upperMonths,this._upperMonthsGenitive)},_getAbbrMonthIndex:function(a){if(!this._upperAbbrMonths){this._upperAbbrMonths=this._toUpperArray(this.dateTimeFormat.AbbreviatedMonthNames);this._upperAbbrMonthsGenitive=this._toUpperArray(this.dateTimeFormat.AbbreviatedMonthGenitiveNames)}return this._getIndex(a,this._upperAbbrMonths,this._upperAbbrMonthsGenitive)},_getDayIndex:function(a){if(!this._upperDays)this._upperDays=this._toUpperArray(this.dateTimeFormat.DayNames);return Array.indexOf(this._upperDays,this._toUpper(a))},_getAbbrDayIndex:function(a){if(!this._upperAbbrDays)this._upperAbbrDays=this._toUpperArray(this.dateTimeFormat.AbbreviatedDayNames);return Array.indexOf(this._upperAbbrDays,this._toUpper(a))},_toUpperArray:function(c){var b=[];for(var a=0,d=c.length;a<d;a++)b[a]=this._toUpper(c[a]);return b},_toUpper:function(a){return a.split("\u00a0").join(" ").toUpperCase()}};Sys.CultureInfo.registerClass("Sys.CultureInfo");Sys.CultureInfo._parse=function(a){var b=a.dateTimeFormat;if(b&&!b.eras)b.eras=a.eras;return new Sys.CultureInfo(a.name,a.numberFormat,b)};Sys.CultureInfo.InvariantCulture=Sys.CultureInfo._parse({"name":"","numberFormat":{"CurrencyDecimalDigits":2,"CurrencyDecimalSeparator":".","IsReadOnly":true,"CurrencyGroupSizes":[3],"NumberGroupSizes":[3],"PercentGroupSizes":[3],"CurrencyGroupSeparator":",","CurrencySymbol":"\u00a4","NaNSymbol":"NaN","CurrencyNegativePattern":0,"NumberNegativePattern":1,"PercentPositivePattern":0,"PercentNegativePattern":0,"NegativeInfinitySymbol":"-Infinity","NegativeSign":"-","NumberDecimalDigits":2,"NumberDecimalSeparator":".","NumberGroupSeparator":",","CurrencyPositivePattern":0,"PositiveInfinitySymbol":"Infinity","PositiveSign":"+","PercentDecimalDigits":2,"PercentDecimalSeparator":".","PercentGroupSeparator":",","PercentSymbol":"%","PerMilleSymbol":"\u2030","NativeDigits":["0","1","2","3","4","5","6","7","8","9"],"DigitSubstitution":1},"dateTimeFormat":{"AMDesignator":"AM","Calendar":{"MinSupportedDateTime":"@-62135568000000@","MaxSupportedDateTime":"@253402300799999@","AlgorithmType":1,"CalendarType":1,"Eras":[1],"TwoDigitYearMax":2029,"IsReadOnly":true},"DateSeparator":"/","FirstDayOfWeek":0,"CalendarWeekRule":0,"FullDateTimePattern":"dddd, dd MMMM yyyy HH:mm:ss","LongDatePattern":"dddd, dd MMMM yyyy","LongTimePattern":"HH:mm:ss","MonthDayPattern":"MMMM dd","PMDesignator":"PM","RFC1123Pattern":"ddd, dd MMM yyyy HH':'mm':'ss 'GMT'","ShortDatePattern":"MM/dd/yyyy","ShortTimePattern":"HH:mm","SortableDateTimePattern":"yyyy'-'MM'-'dd'T'HH':'mm':'ss","TimeSeparator":":","UniversalSortableDateTimePattern":"yyyy'-'MM'-'dd HH':'mm':'ss'Z'","YearMonthPattern":"yyyy MMMM","AbbreviatedDayNames":["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],"ShortestDayNames":["Su","Mo","Tu","We","Th","Fr","Sa"],"DayNames":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],"AbbreviatedMonthNames":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec",""],"MonthNames":["January","February","March","April","May","June","July","August","September","October","November","December",""],"IsReadOnly":true,"NativeCalendarName":"Gregorian Calendar","AbbreviatedMonthGenitiveNames":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec",""],"MonthGenitiveNames":["January","February","March","April","May","June","July","August","September","October","November","December",""]},"eras":[1,"A.D.",null,0]});if(typeof __cultureInfo==="object"){Sys.CultureInfo.CurrentCulture=Sys.CultureInfo._parse(__cultureInfo);delete __cultureInfo}else Sys.CultureInfo.CurrentCulture=Sys.CultureInfo._parse({"name":"en-US","numberFormat":{"CurrencyDecimalDigits":2,"CurrencyDecimalSeparator":".","IsReadOnly":false,"CurrencyGroupSizes":[3],"NumberGroupSizes":[3],"PercentGroupSizes":[3],"CurrencyGroupSeparator":",","CurrencySymbol":"$","NaNSymbol":"NaN","CurrencyNegativePattern":0,"NumberNegativePattern":1,"PercentPositivePattern":0,"PercentNegativePattern":0,"NegativeInfinitySymbol":"-Infinity","NegativeSign":"-","NumberDecimalDigits":2,"NumberDecimalSeparator":".","NumberGroupSeparator":",","CurrencyPositivePattern":0,"PositiveInfinitySymbol":"Infinity","PositiveSign":"+","PercentDecimalDigits":2,"PercentDecimalSeparator":".","PercentGroupSeparator":",","PercentSymbol":"%","PerMilleSymbol":"\u2030","NativeDigits":["0","1","2","3","4","5","6","7","8","9"],"DigitSubstitution":1},"dateTimeFormat":{"AMDesignator":"AM","Calendar":{"MinSupportedDateTime":"@-62135568000000@","MaxSupportedDateTime":"@253402300799999@","AlgorithmType":1,"CalendarType":1,"Eras":[1],"TwoDigitYearMax":2029,"IsReadOnly":false},"DateSeparator":"/","FirstDayOfWeek":0,"CalendarWeekRule":0,"FullDateTimePattern":"dddd, MMMM dd, yyyy h:mm:ss tt","LongDatePattern":"dddd, MMMM dd, yyyy","LongTimePattern":"h:mm:ss tt","MonthDayPattern":"MMMM dd","PMDesignator":"PM","RFC1123Pattern":"ddd, dd MMM yyyy HH':'mm':'ss 'GMT'","ShortDatePattern":"M/d/yyyy","ShortTimePattern":"h:mm tt","SortableDateTimePattern":"yyyy'-'MM'-'dd'T'HH':'mm':'ss","TimeSeparator":":","UniversalSortableDateTimePattern":"yyyy'-'MM'-'dd HH':'mm':'ss'Z'","YearMonthPattern":"MMMM, yyyy","AbbreviatedDayNames":["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],"ShortestDayNames":["Su","Mo","Tu","We","Th","Fr","Sa"],"DayNames":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],"AbbreviatedMonthNames":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec",""],"MonthNames":["January","February","March","April","May","June","July","August","September","October","November","December",""],"IsReadOnly":false,"NativeCalendarName":"Gregorian Calendar","AbbreviatedMonthGenitiveNames":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec",""],"MonthGenitiveNames":["January","February","March","April","May","June","July","August","September","October","November","December",""]},"eras":[1,"A.D.",null,0]});Type.registerNamespace("Sys.Serialization");Sys.Serialization.JavaScriptSerializer=function(){};Sys.Serialization.JavaScriptSerializer.registerClass("Sys.Serialization.JavaScriptSerializer");Sys.Serialization.JavaScriptSerializer._charsToEscapeRegExs=[];Sys.Serialization.JavaScriptSerializer._charsToEscape=[];Sys.Serialization.JavaScriptSerializer._dateRegEx=new RegExp('(^|[^\\\\])\\"\\\\/Date\\((-?[0-9]+)(?:[a-zA-Z]|(?:\\+|-)[0-9]{4})?\\)\\\\/\\"',"g");Sys.Serialization.JavaScriptSerializer._escapeChars={};Sys.Serialization.JavaScriptSerializer._escapeRegEx=new RegExp('["\\\\\\x00-\\x1F]',"i");Sys.Serialization.JavaScriptSerializer._escapeRegExGlobal=new RegExp('["\\\\\\x00-\\x1F]',"g");Sys.Serialization.JavaScriptSerializer._jsonRegEx=new RegExp("[^,:{}\\[\\]0-9.\\-+Eaeflnr-u \\n\\r\\t]","g");Sys.Serialization.JavaScriptSerializer._jsonStringRegEx=new RegExp('"(\\\\.|[^"\\\\])*"',"g");Sys.Serialization.JavaScriptSerializer._serverTypeFieldName="__type";Sys.Serialization.JavaScriptSerializer._init=function(){var c=["\\u0000","\\u0001","\\u0002","\\u0003","\\u0004","\\u0005","\\u0006","\\u0007","\\b","\\t","\\n","\\u000b","\\f","\\r","\\u000e","\\u000f","\\u0010","\\u0011","\\u0012","\\u0013","\\u0014","\\u0015","\\u0016","\\u0017","\\u0018","\\u0019","\\u001a","\\u001b","\\u001c","\\u001d","\\u001e","\\u001f"];Sys.Serialization.JavaScriptSerializer._charsToEscape[0]="\\";Sys.Serialization.JavaScriptSerializer._charsToEscapeRegExs["\\"]=new RegExp("\\\\","g");Sys.Serialization.JavaScriptSerializer._escapeChars["\\"]="\\\\";Sys.Serialization.JavaScriptSerializer._charsToEscape[1]='"';Sys.Serialization.JavaScriptSerializer._charsToEscapeRegExs['"']=new RegExp('"',"g");Sys.Serialization.JavaScriptSerializer._escapeChars['"']='\\"';for(var a=0;a<32;a++){var b=String.fromCharCode(a);Sys.Serialization.JavaScriptSerializer._charsToEscape[a+2]=b;Sys.Serialization.JavaScriptSerializer._charsToEscapeRegExs[b]=new RegExp(b,"g");Sys.Serialization.JavaScriptSerializer._escapeChars[b]=c[a]}};Sys.Serialization.JavaScriptSerializer._serializeBooleanWithBuilder=function(b,a){a.append(b.toString())};Sys.Serialization.JavaScriptSerializer._serializeNumberWithBuilder=function(a,b){if(isFinite(a))b.append(String(a));else throw Error.invalidOperation(Sys.Res.cannotSerializeNonFiniteNumbers)};Sys.Serialization.JavaScriptSerializer._serializeStringWithBuilder=function(a,c){c.append('"');if(Sys.Serialization.JavaScriptSerializer._escapeRegEx.test(a)){if(Sys.Serialization.JavaScriptSerializer._charsToEscape.length===0)Sys.Serialization.JavaScriptSerializer._init();if(a.length<128)a=a.replace(Sys.Serialization.JavaScriptSerializer._escapeRegExGlobal,function(a){return Sys.Serialization.JavaScriptSerializer._escapeChars[a]});else for(var d=0;d<34;d++){var b=Sys.Serialization.JavaScriptSerializer._charsToEscape[d];if(a.indexOf(b)!==-1)if(Sys.Browser.agent===Sys.Browser.Opera||Sys.Browser.agent===Sys.Browser.FireFox)a=a.split(b).join(Sys.Serialization.JavaScriptSerializer._escapeChars[b]);else a=a.replace(Sys.Serialization.JavaScriptSerializer._charsToEscapeRegExs[b],Sys.Serialization.JavaScriptSerializer._escapeChars[b])}}c.append(a);c.append('"')};Sys.Serialization.JavaScriptSerializer._serializeWithBuilder=function(b,a,i,g){var c;switch(typeof b){case "object":if(b)if(Number.isInstanceOfType(b))Sys.Serialization.JavaScriptSerializer._serializeNumberWithBuilder(b,a);else if(Boolean.isInstanceOfType(b))Sys.Serialization.JavaScriptSerializer._serializeBooleanWithBuilder(b,a);else if(String.isInstanceOfType(b))Sys.Serialization.JavaScriptSerializer._serializeStringWithBuilder(b,a);else if(Array.isInstanceOfType(b)){a.append("[");for(c=0;c<b.length;++c){if(c>0)a.append(",");Sys.Serialization.JavaScriptSerializer._serializeWithBuilder(b[c],a,false,g)}a.append("]")}else{if(Date.isInstanceOfType(b)){a.append('"\\/Date(');a.append(b.getTime());a.append(')\\/"');break}var d=[],f=0;for(var e in b){if(e.startsWith("$"))continue;if(e===Sys.Serialization.JavaScriptSerializer._serverTypeFieldName&&f!==0){d[f++]=d[0];d[0]=e}else d[f++]=e}if(i)d.sort();a.append("{");var j=false;for(c=0;c<f;c++){var h=b[d[c]];if(typeof h!=="undefined"&&typeof h!=="function"){if(j)a.append(",");else j=true;Sys.Serialization.JavaScriptSerializer._serializeWithBuilder(d[c],a,i,g);a.append(":");Sys.Serialization.JavaScriptSerializer._serializeWithBuilder(h,a,i,g)}}a.append("}")}else a.append("null");break;case "number":Sys.Serialization.JavaScriptSerializer._serializeNumberWithBuilder(b,a);break;case "string":Sys.Serialization.JavaScriptSerializer._serializeStringWithBuilder(b,a);break;case "boolean":Sys.Serialization.JavaScriptSerializer._serializeBooleanWithBuilder(b,a);break;default:a.append("null")}};Sys.Serialization.JavaScriptSerializer.serialize=function(b){var a=new Sys.StringBuilder;Sys.Serialization.JavaScriptSerializer._serializeWithBuilder(b,a,false);return a.toString()};Sys.Serialization.JavaScriptSerializer.deserialize=function(data,secure){if(data.length===0)throw Error.argument("data",Sys.Res.cannotDeserializeEmptyString);try{var exp=data.replace(Sys.Serialization.JavaScriptSerializer._dateRegEx,"$1new Date($2)");if(secure&&Sys.Serialization.JavaScriptSerializer._jsonRegEx.test(exp.replace(Sys.Serialization.JavaScriptSerializer._jsonStringRegEx,"")))throw null;return eval("("+exp+")")}catch(a){throw Error.argument("data",Sys.Res.cannotDeserializeInvalidJson)}};Type.registerNamespace("Sys.UI");Sys.EventHandlerList=function(){this._list={}};Sys.EventHandlerList.prototype={_addHandler:function(b,a){Array.add(this._getEvent(b,true),a)},addHandler:function(b,a){this._addHandler(b,a)},_removeHandler:function(c,b){var a=this._getEvent(c);if(!a)return;Array.remove(a,b)},removeHandler:function(b,a){this._removeHandler(b,a)},getHandler:function(b){var a=this._getEvent(b);if(!a||a.length===0)return null;a=Array.clone(a);return function(c,d){for(var b=0,e=a.length;b<e;b++)a[b](c,d)}},_getEvent:function(a,b){if(!this._list[a]){if(!b)return null;this._list[a]=[]}return this._list[a]}};Sys.EventHandlerList.registerClass("Sys.EventHandlerList");Sys.CommandEventArgs=function(c,a,b){Sys.CommandEventArgs.initializeBase(this);this._commandName=c;this._commandArgument=a;this._commandSource=b};Sys.CommandEventArgs.prototype={_commandName:null,_commandArgument:null,_commandSource:null,get_commandName:function(){return this._commandName},get_commandArgument:function(){return this._commandArgument},get_commandSource:function(){return this._commandSource}};Sys.CommandEventArgs.registerClass("Sys.CommandEventArgs",Sys.CancelEventArgs);Sys.INotifyPropertyChange=function(){};Sys.INotifyPropertyChange.prototype={};Sys.INotifyPropertyChange.registerInterface("Sys.INotifyPropertyChange");Sys.PropertyChangedEventArgs=function(a){Sys.PropertyChangedEventArgs.initializeBase(this);this._propertyName=a};Sys.PropertyChangedEventArgs.prototype={get_propertyName:function(){return this._propertyName}};Sys.PropertyChangedEventArgs.registerClass("Sys.PropertyChangedEventArgs",Sys.EventArgs);Sys.INotifyDisposing=function(){};Sys.INotifyDisposing.prototype={};Sys.INotifyDisposing.registerInterface("Sys.INotifyDisposing");Sys.Component=function(){if(Sys.Application)Sys.Application.registerDisposableObject(this)};Sys.Component.prototype={_id:null,_initialized:false,_updating:false,get_events:function(){if(!this._events)this._events=new Sys.EventHandlerList;return this._events},get_id:function(){return this._id},set_id:function(a){this._id=a},get_isInitialized:function(){return this._initialized},get_isUpdating:function(){return this._updating},add_disposing:function(a){this.get_events().addHandler("disposing",a)},remove_disposing:function(a){this.get_events().removeHandler("disposing",a)},add_propertyChanged:function(a){this.get_events().addHandler("propertyChanged",a)},remove_propertyChanged:function(a){this.get_events().removeHandler("propertyChanged",a)},beginUpdate:function(){this._updating=true},dispose:function(){if(this._events){var a=this._events.getHandler("disposing");if(a)a(this,Sys.EventArgs.Empty)}delete this._events;Sys.Application.unregisterDisposableObject(this);Sys.Application.removeComponent(this)},endUpdate:function(){this._updating=false;if(!this._initialized)this.initialize();this.updated()},initialize:function(){this._initialized=true},raisePropertyChanged:function(b){if(!this._events)return;var a=this._events.getHandler("propertyChanged");if(a)a(this,new Sys.PropertyChangedEventArgs(b))},updated:function(){}};Sys.Component.registerClass("Sys.Component",null,Sys.IDisposable,Sys.INotifyPropertyChange,Sys.INotifyDisposing);function Sys$Component$_setProperties(a,i){var d,j=Object.getType(a),e=j===Object||j===Sys.UI.DomElement,h=Sys.Component.isInstanceOfType(a)&&!a.get_isUpdating();if(h)a.beginUpdate();for(var c in i){var b=i[c],f=e?null:a["get_"+c];if(e||typeof f!=="function"){var k=a[c];if(!b||typeof b!=="object"||e&&!k)a[c]=b;else Sys$Component$_setProperties(k,b)}else{var l=a["set_"+c];if(typeof l==="function")l.apply(a,[b]);else if(b instanceof Array){d=f.apply(a);for(var g=0,m=d.length,n=b.length;g<n;g++,m++)d[m]=b[g]}else if(typeof b==="object"&&Object.getType(b)===Object){d=f.apply(a);Sys$Component$_setProperties(d,b)}}}if(h)a.endUpdate()}function Sys$Component$_setReferences(c,b){for(var a in b){var e=c["set_"+a],d=$find(b[a]);e.apply(c,[d])}}var $create=Sys.Component.create=function(h,f,d,c,g){var a=g?new h(g):new h,b=Sys.Application,i=b.get_isCreatingComponents();a.beginUpdate();if(f)Sys$Component$_setProperties(a,f);if(d)for(var e in d)a["add_"+e](d[e]);if(a.get_id())b.addComponent(a);if(i){b._createdComponents[b._createdComponents.length]=a;if(c)b._addComponentToSecondPass(a,c);else a.endUpdate()}else{if(c)Sys$Component$_setReferences(a,c);a.endUpdate()}return a};Sys.UI.MouseButton=function(){throw Error.notImplemented()};Sys.UI.MouseButton.prototype={leftButton:0,middleButton:1,rightButton:2};Sys.UI.MouseButton.registerEnum("Sys.UI.MouseButton");Sys.UI.Key=function(){throw Error.notImplemented()};Sys.UI.Key.prototype={backspace:8,tab:9,enter:13,esc:27,space:32,pageUp:33,pageDown:34,end:35,home:36,left:37,up:38,right:39,down:40,del:127};Sys.UI.Key.registerEnum("Sys.UI.Key");Sys.UI.Point=function(a,b){this.x=a;this.y=b};Sys.UI.Point.registerClass("Sys.UI.Point");Sys.UI.Bounds=function(c,d,b,a){this.x=c;this.y=d;this.height=a;this.width=b};Sys.UI.Bounds.registerClass("Sys.UI.Bounds");Sys.UI.DomEvent=function(e){var a=e,b=this.type=a.type.toLowerCase();this.rawEvent=a;this.altKey=a.altKey;if(typeof a.button!=="undefined")this.button=typeof a.which!=="undefined"?a.button:a.button===4?Sys.UI.MouseButton.middleButton:a.button===2?Sys.UI.MouseButton.rightButton:Sys.UI.MouseButton.leftButton;if(b==="keypress")this.charCode=a.charCode||a.keyCode;else if(a.keyCode&&a.keyCode===46)this.keyCode=127;else this.keyCode=a.keyCode;this.clientX=a.clientX;this.clientY=a.clientY;this.ctrlKey=a.ctrlKey;this.target=a.target?a.target:a.srcElement;if(!b.startsWith("key"))if(typeof a.offsetX!=="undefined"&&typeof a.offsetY!=="undefined"){this.offsetX=a.offsetX;this.offsetY=a.offsetY}else if(this.target&&this.target.nodeType!==3&&typeof a.clientX==="number"){var c=Sys.UI.DomElement.getLocation(this.target),d=Sys.UI.DomElement._getWindow(this.target);this.offsetX=(d.pageXOffset||0)+a.clientX-c.x;this.offsetY=(d.pageYOffset||0)+a.clientY-c.y}this.screenX=a.screenX;this.screenY=a.screenY;this.shiftKey=a.shiftKey};Sys.UI.DomEvent.prototype={preventDefault:function(){if(this.rawEvent.preventDefault)this.rawEvent.preventDefault();else if(window.event)this.rawEvent.returnValue=false},stopPropagation:function(){if(this.rawEvent.stopPropagation)this.rawEvent.stopPropagation();else if(window.event)this.rawEvent.cancelBubble=true}};Sys.UI.DomEvent.registerClass("Sys.UI.DomEvent");var $addHandler=Sys.UI.DomEvent.addHandler=function(a,d,e,g){if(!a._events)a._events={};var c=a._events[d];if(!c)a._events[d]=c=[];var b;if(a.addEventListener){b=function(b){return e.call(a,new Sys.UI.DomEvent(b))};a.addEventListener(d,b,false)}else if(a.attachEvent){b=function(){var b={};try{b=Sys.UI.DomElement._getWindow(a).event}catch(c){}return e.call(a,new Sys.UI.DomEvent(b))};a.attachEvent("on"+d,b)}c[c.length]={handler:e,browserHandler:b,autoRemove:g};if(g){var f=a.dispose;if(f!==Sys.UI.DomEvent._disposeHandlers){a.dispose=Sys.UI.DomEvent._disposeHandlers;if(typeof f!=="undefined")a._chainDispose=f}}},$addHandlers=Sys.UI.DomEvent.addHandlers=function(f,d,c,e){for(var b in d){var a=d[b];if(c)a=Function.createDelegate(c,a);$addHandler(f,b,a,e||false)}},$clearHandlers=Sys.UI.DomEvent.clearHandlers=function(a){Sys.UI.DomEvent._clearHandlers(a,false)};Sys.UI.DomEvent._clearHandlers=function(a,g){if(a._events){var e=a._events;for(var b in e){var d=e[b];for(var c=d.length-1;c>=0;c--){var f=d[c];if(!g||f.autoRemove)$removeHandler(a,b,f.handler)}}a._events=null}};Sys.UI.DomEvent._disposeHandlers=function(){Sys.UI.DomEvent._clearHandlers(this,true);var b=this._chainDispose,a=typeof b;if(a!=="undefined"){this.dispose=b;this._chainDispose=null;if(a==="function")this.dispose()}};var $removeHandler=Sys.UI.DomEvent.removeHandler=function(b,a,c){Sys.UI.DomEvent._removeHandler(b,a,c)};Sys.UI.DomEvent._removeHandler=function(a,e,f){var d=null,c=a._events[e];for(var b=0,g=c.length;b<g;b++)if(c[b].handler===f){d=c[b].browserHandler;break}if(a.removeEventListener)a.removeEventListener(e,d,false);else if(a.detachEvent)a.detachEvent("on"+e,d);c.splice(b,1)};Sys.UI.DomElement=function(){};Sys.UI.DomElement.registerClass("Sys.UI.DomElement");Sys.UI.DomElement.addCssClass=function(a,b){if(!Sys.UI.DomElement.containsCssClass(a,b))if(a.className==="")a.className=b;else a.className+=" "+b};Sys.UI.DomElement.containsCssClass=function(b,a){return Array.contains(b.className.split(" "),a)};Sys.UI.DomElement.getBounds=function(a){var b=Sys.UI.DomElement.getLocation(a);return new Sys.UI.Bounds(b.x,b.y,a.offsetWidth||0,a.offsetHeight||0)};var $get=Sys.UI.DomElement.getElementById=function(f,e){if(!e)return document.getElementById(f);if(e.getElementById)return e.getElementById(f);var c=[],d=e.childNodes;for(var b=0;b<d.length;b++){var a=d[b];if(a.nodeType==1)c[c.length]=a}while(c.length){a=c.shift();if(a.id==f)return a;d=a.childNodes;for(b=0;b<d.length;b++){a=d[b];if(a.nodeType==1)c[c.length]=a}}return null};if(document.documentElement.getBoundingClientRect)Sys.UI.DomElement.getLocation=function(b){if(b.self||b.nodeType===9||b===document.documentElement||b.parentNode===b.ownerDocument.documentElement)return new Sys.UI.Point(0,0);var f=b.getBoundingClientRect();if(!f)return new Sys.UI.Point(0,0);var k,e=b.ownerDocument.documentElement,c=Math.round(f.left)+e.scrollLeft,d=Math.round(f.top)+e.scrollTop;if(Sys.Browser.agent===Sys.Browser.InternetExplorer){try{var g=b.ownerDocument.parentWindow.frameElement||null;if(g){var h=g.frameBorder==="0"||g.frameBorder==="no"?2:0;c+=h;d+=h}}catch(l){}if(Sys.Browser.version===7&&!document.documentMode){var i=document.body,j=i.getBoundingClientRect(),a=(j.right-j.left)/i.clientWidth;a=Math.round(a*100);a=(a-a%5)/100;if(!isNaN(a)&&a!==1){c=Math.round(c/a);d=Math.round(d/a)}}if((document.documentMode||0)<8){c-=e.clientLeft;d-=e.clientTop}}return new Sys.UI.Point(c,d)};else if(Sys.Browser.agent===Sys.Browser.Safari)Sys.UI.DomElement.getLocation=function(c){if(c.window&&c.window===c||c.nodeType===9)return new Sys.UI.Point(0,0);var d=0,e=0,a,j=null,g=null,b;for(a=c;a;j=a,(g=b,a=a.offsetParent)){b=Sys.UI.DomElement._getCurrentStyle(a);var f=a.tagName?a.tagName.toUpperCase():null;if((a.offsetLeft||a.offsetTop)&&(f!=="BODY"||(!g||g.position!=="absolute"))){d+=a.offsetLeft;e+=a.offsetTop}if(j&&Sys.Browser.version>=3){d+=parseInt(b.borderLeftWidth);e+=parseInt(b.borderTopWidth)}}b=Sys.UI.DomElement._getCurrentStyle(c);var h=b?b.position:null;if(!h||h!=="absolute")for(a=c.parentNode;a;a=a.parentNode){f=a.tagName?a.tagName.toUpperCase():null;if(f!=="BODY"&&f!=="HTML"&&(a.scrollLeft||a.scrollTop)){d-=a.scrollLeft||0;e-=a.scrollTop||0}b=Sys.UI.DomElement._getCurrentStyle(a);var i=b?b.position:null;if(i&&i==="absolute")break}return new Sys.UI.Point(d,e)};else Sys.UI.DomElement.getLocation=function(d){if(d.window&&d.window===d||d.nodeType===9)return new Sys.UI.Point(0,0);var e=0,f=0,a,i=null,g=null,b=null;for(a=d;a;i=a,(g=b,a=a.offsetParent)){var c=a.tagName?a.tagName.toUpperCase():null;b=Sys.UI.DomElement._getCurrentStyle(a);if((a.offsetLeft||a.offsetTop)&&!(c==="BODY"&&(!g||g.position!=="absolute"))){e+=a.offsetLeft;f+=a.offsetTop}if(i!==null&&b){if(c!=="TABLE"&&c!=="TD"&&c!=="HTML"){e+=parseInt(b.borderLeftWidth)||0;f+=parseInt(b.borderTopWidth)||0}if(c==="TABLE"&&(b.position==="relative"||b.position==="absolute")){e+=parseInt(b.marginLeft)||0;f+=parseInt(b.marginTop)||0}}}b=Sys.UI.DomElement._getCurrentStyle(d);var h=b?b.position:null;if(!h||h!=="absolute")for(a=d.parentNode;a;a=a.parentNode){c=a.tagName?a.tagName.toUpperCase():null;if(c!=="BODY"&&c!=="HTML"&&(a.scrollLeft||a.scrollTop)){e-=a.scrollLeft||0;f-=a.scrollTop||0;b=Sys.UI.DomElement._getCurrentStyle(a);if(b){e+=parseInt(b.borderLeftWidth)||0;f+=parseInt(b.borderTopWidth)||0}}}return new Sys.UI.Point(e,f)};Sys.UI.DomElement.isDomElement=function(a){return Sys._isDomElement(a)};Sys.UI.DomElement.removeCssClass=function(d,c){var a=" "+d.className+" ",b=a.indexOf(" "+c+" ");if(b>=0)d.className=(a.substr(0,b)+" "+a.substring(b+c.length+1,a.length)).trim()};Sys.UI.DomElement.resolveElement=function(b,c){var a=b;if(!a)return null;if(typeof a==="string")a=Sys.UI.DomElement.getElementById(a,c);return a};Sys.UI.DomElement.raiseBubbleEvent=function(c,d){var b=c;while(b){var a=b.control;if(a&&a.onBubbleEvent&&a.raiseBubbleEvent){Sys.UI.DomElement._raiseBubbleEventFromControl(a,c,d);return}b=b.parentNode}};Sys.UI.DomElement._raiseBubbleEventFromControl=function(a,b,c){if(!a.onBubbleEvent(b,c))a._raiseBubbleEvent(b,c)};Sys.UI.DomElement.setLocation=function(b,c,d){var a=b.style;a.position="absolute";a.left=c+"px";a.top=d+"px"};Sys.UI.DomElement.toggleCssClass=function(b,a){if(Sys.UI.DomElement.containsCssClass(b,a))Sys.UI.DomElement.removeCssClass(b,a);else Sys.UI.DomElement.addCssClass(b,a)};Sys.UI.DomElement.getVisibilityMode=function(a){return a._visibilityMode===Sys.UI.VisibilityMode.hide?Sys.UI.VisibilityMode.hide:Sys.UI.VisibilityMode.collapse};Sys.UI.DomElement.setVisibilityMode=function(a,b){Sys.UI.DomElement._ensureOldDisplayMode(a);if(a._visibilityMode!==b){a._visibilityMode=b;if(Sys.UI.DomElement.getVisible(a)===false)if(a._visibilityMode===Sys.UI.VisibilityMode.hide)a.style.display=a._oldDisplayMode;else a.style.display="none";a._visibilityMode=b}};Sys.UI.DomElement.getVisible=function(b){var a=b.currentStyle||Sys.UI.DomElement._getCurrentStyle(b);if(!a)return true;return a.visibility!=="hidden"&&a.display!=="none"};Sys.UI.DomElement.setVisible=function(a,b){if(b!==Sys.UI.DomElement.getVisible(a)){Sys.UI.DomElement._ensureOldDisplayMode(a);a.style.visibility=b?"visible":"hidden";if(b||a._visibilityMode===Sys.UI.VisibilityMode.hide)a.style.display=a._oldDisplayMode;else a.style.display="none"}};Sys.UI.DomElement._ensureOldDisplayMode=function(a){if(!a._oldDisplayMode){var b=a.currentStyle||Sys.UI.DomElement._getCurrentStyle(a);a._oldDisplayMode=b?b.display:null;if(!a._oldDisplayMode||a._oldDisplayMode==="none")switch(a.tagName.toUpperCase()){case "DIV":case "P":case "ADDRESS":case "BLOCKQUOTE":case "BODY":case "COL":case "COLGROUP":case "DD":case "DL":case "DT":case "FIELDSET":case "FORM":case "H1":case "H2":case "H3":case "H4":case "H5":case "H6":case "HR":case "IFRAME":case "LEGEND":case "OL":case "PRE":case "TABLE":case "TD":case "TH":case "TR":case "UL":a._oldDisplayMode="block";break;case "LI":a._oldDisplayMode="list-item";break;default:a._oldDisplayMode="inline"}}};Sys.UI.DomElement._getWindow=function(a){var b=a.ownerDocument||a.document||a;return b.defaultView||b.parentWindow};Sys.UI.DomElement._getCurrentStyle=function(a){if(a.nodeType===3)return null;var c=Sys.UI.DomElement._getWindow(a);if(a.documentElement)a=a.documentElement;var b=c&&a!==c&&c.getComputedStyle?c.getComputedStyle(a,null):a.currentStyle||a.style;if(!b&&Sys.Browser.agent===Sys.Browser.Safari&&a.style){var g=a.style.display,f=a.style.position;a.style.position="absolute";a.style.display="block";var e=c.getComputedStyle(a,null);a.style.display=g;a.style.position=f;b={};for(var d in e)b[d]=e[d];b.display="none"}return b};Sys.IContainer=function(){};Sys.IContainer.prototype={};Sys.IContainer.registerInterface("Sys.IContainer");Sys.ApplicationLoadEventArgs=function(b,a){Sys.ApplicationLoadEventArgs.initializeBase(this);this._components=b;this._isPartialLoad=a};Sys.ApplicationLoadEventArgs.prototype={get_components:function(){return this._components},get_isPartialLoad:function(){return this._isPartialLoad}};Sys.ApplicationLoadEventArgs.registerClass("Sys.ApplicationLoadEventArgs",Sys.EventArgs);Sys._Application=function(){Sys._Application.initializeBase(this);this._disposableObjects=[];this._components={};this._createdComponents=[];this._secondPassComponents=[];this._unloadHandlerDelegate=Function.createDelegate(this,this._unloadHandler);Sys.UI.DomEvent.addHandler(window,"unload",this._unloadHandlerDelegate);this._domReady()};Sys._Application.prototype={_creatingComponents:false,_disposing:false,_deleteCount:0,get_isCreatingComponents:function(){return this._creatingComponents},get_isDisposing:function(){return this._disposing},add_init:function(a){if(this._initialized)a(this,Sys.EventArgs.Empty);else this.get_events().addHandler("init",a)},remove_init:function(a){this.get_events().removeHandler("init",a)},add_load:function(a){this.get_events().addHandler("load",a)},remove_load:function(a){this.get_events().removeHandler("load",a)},add_unload:function(a){this.get_events().addHandler("unload",a)},remove_unload:function(a){this.get_events().removeHandler("unload",a)},addComponent:function(a){this._components[a.get_id()]=a},beginCreateComponents:function(){this._creatingComponents=true},dispose:function(){if(!this._disposing){this._disposing=true;if(this._timerCookie){window.clearTimeout(this._timerCookie);delete this._timerCookie}if(this._endRequestHandler){Sys.WebForms.PageRequestManager.getInstance().remove_endRequest(this._endRequestHandler);delete this._endRequestHandler}if(this._beginRequestHandler){Sys.WebForms.PageRequestManager.getInstance().remove_beginRequest(this._beginRequestHandler);delete this._beginRequestHandler}if(window.pageUnload)window.pageUnload(this,Sys.EventArgs.Empty);var c=this.get_events().getHandler("unload");if(c)c(this,Sys.EventArgs.Empty);var b=Array.clone(this._disposableObjects);for(var a=0,f=b.length;a<f;a++){var d=b[a];if(typeof d!=="undefined")d.dispose()}Array.clear(this._disposableObjects);Sys.UI.DomEvent.removeHandler(window,"unload",this._unloadHandlerDelegate);if(Sys._ScriptLoader){var e=Sys._ScriptLoader.getInstance();if(e)e.dispose()}Sys._Application.callBaseMethod(this,"dispose")}},disposeElement:function(c,j){if(c.nodeType===1){var b,h=c.getElementsByTagName("*"),g=h.length,i=new Array(g);for(b=0;b<g;b++)i[b]=h[b];for(b=g-1;b>=0;b--){var d=i[b],f=d.dispose;if(f&&typeof f==="function")d.dispose();else{var e=d.control;if(e&&typeof e.dispose==="function")e.dispose()}var a=d._behaviors;if(a)this._disposeComponents(a);a=d._components;if(a){this._disposeComponents(a);d._components=null}}if(!j){var f=c.dispose;if(f&&typeof f==="function")c.dispose();else{var e=c.control;if(e&&typeof e.dispose==="function")e.dispose()}var a=c._behaviors;if(a)this._disposeComponents(a);a=c._components;if(a){this._disposeComponents(a);c._components=null}}}},endCreateComponents:function(){var b=this._secondPassComponents;for(var a=0,d=b.length;a<d;a++){var c=b[a].component;Sys$Component$_setReferences(c,b[a].references);c.endUpdate()}this._secondPassComponents=[];this._creatingComponents=false},findComponent:function(b,a){return a?Sys.IContainer.isInstanceOfType(a)?a.findComponent(b):a[b]||null:Sys.Application._components[b]||null},getComponents:function(){var a=[],b=this._components;for(var c in b)a[a.length]=b[c];return a},initialize:function(){if(!this.get_isInitialized()&&!this._disposing){Sys._Application.callBaseMethod(this,"initialize");this._raiseInit();if(this.get_stateString){if(Sys.WebForms&&Sys.WebForms.PageRequestManager){this._beginRequestHandler=Function.createDelegate(this,this._onPageRequestManagerBeginRequest);Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(this._beginRequestHandler);this._endRequestHandler=Function.createDelegate(this,this._onPageRequestManagerEndRequest);Sys.WebForms.PageRequestManager.getInstance().add_endRequest(this._endRequestHandler)}var a=this.get_stateString();if(a!==this._currentEntry)this._navigate(a);else this._ensureHistory()}this.raiseLoad()}},notifyScriptLoaded:function(){},registerDisposableObject:function(b){if(!this._disposing){var a=this._disposableObjects,c=a.length;a[c]=b;b.__msdisposeindex=c}},raiseLoad:function(){var b=this.get_events().getHandler("load"),a=new Sys.ApplicationLoadEventArgs(Array.clone(this._createdComponents),!!this._loaded);this._loaded=true;if(b)b(this,a);if(window.pageLoad)window.pageLoad(this,a);this._createdComponents=[]},removeComponent:function(b){var a=b.get_id();if(a)delete this._components[a]},unregisterDisposableObject:function(a){if(!this._disposing){var e=a.__msdisposeindex;if(typeof e==="number"){var b=this._disposableObjects;delete b[e];delete a.__msdisposeindex;if(++this._deleteCount>1000){var c=[];for(var d=0,f=b.length;d<f;d++){a=b[d];if(typeof a!=="undefined"){a.__msdisposeindex=c.length;c.push(a)}}this._disposableObjects=c;this._deleteCount=0}}}},_addComponentToSecondPass:function(b,a){this._secondPassComponents[this._secondPassComponents.length]={component:b,references:a}},_disposeComponents:function(a){if(a)for(var b=a.length-1;b>=0;b--){var c=a[b];if(typeof c.dispose==="function")c.dispose()}},_domReady:function(){var a,g,f=this;function b(){f.initialize()}var c=function(){Sys.UI.DomEvent.removeHandler(window,"load",c);b()};Sys.UI.DomEvent.addHandler(window,"load",c);if(document.addEventListener)try{document.addEventListener("DOMContentLoaded",a=function(){document.removeEventListener("DOMContentLoaded",a,false);b()},false)}catch(h){}else if(document.attachEvent)if(window==window.top&&document.documentElement.doScroll){var e,d=document.createElement("div");a=function(){try{d.doScroll("left")}catch(c){e=window.setTimeout(a,0);return}d=null;b()};a()}else document.attachEvent("onreadystatechange",a=function(){if(document.readyState==="complete"){document.detachEvent("onreadystatechange",a);b()}})},_raiseInit:function(){var a=this.get_events().getHandler("init");if(a){this.beginCreateComponents();a(this,Sys.EventArgs.Empty);this.endCreateComponents()}},_unloadHandler:function(){this.dispose()}};Sys._Application.registerClass("Sys._Application",Sys.Component,Sys.IContainer);Sys.Application=new Sys._Application;var $find=Sys.Application.findComponent;Sys.UI.Behavior=function(b){Sys.UI.Behavior.initializeBase(this);this._element=b;var a=b._behaviors;if(!a)b._behaviors=[this];else a[a.length]=this};Sys.UI.Behavior.prototype={_name:null,get_element:function(){return this._element},get_id:function(){var a=Sys.UI.Behavior.callBaseMethod(this,"get_id");if(a)return a;if(!this._element||!this._element.id)return "";return this._element.id+"$"+this.get_name()},get_name:function(){if(this._name)return this._name;var a=Object.getTypeName(this),b=a.lastIndexOf(".");if(b!==-1)a=a.substr(b+1);if(!this.get_isInitialized())this._name=a;return a},set_name:function(a){this._name=a},initialize:function(){Sys.UI.Behavior.callBaseMethod(this,"initialize");var a=this.get_name();if(a)this._element[a]=this},dispose:function(){Sys.UI.Behavior.callBaseMethod(this,"dispose");var a=this._element;if(a){var c=this.get_name();if(c)a[c]=null;var b=a._behaviors;Array.remove(b,this);if(b.length===0)a._behaviors=null;delete this._element}}};Sys.UI.Behavior.registerClass("Sys.UI.Behavior",Sys.Component);Sys.UI.Behavior.getBehaviorByName=function(b,c){var a=b[c];return a&&Sys.UI.Behavior.isInstanceOfType(a)?a:null};Sys.UI.Behavior.getBehaviors=function(a){if(!a._behaviors)return [];return Array.clone(a._behaviors)};Sys.UI.Behavior.getBehaviorsByType=function(d,e){var a=d._behaviors,c=[];if(a)for(var b=0,f=a.length;b<f;b++)if(e.isInstanceOfType(a[b]))c[c.length]=a[b];return c};Sys.UI.VisibilityMode=function(){throw Error.notImplemented()};Sys.UI.VisibilityMode.prototype={hide:0,collapse:1};Sys.UI.VisibilityMode.registerEnum("Sys.UI.VisibilityMode");Sys.UI.Control=function(a){Sys.UI.Control.initializeBase(this);this._element=a;a.control=this;var b=this.get_role();if(b)a.setAttribute("role",b)};Sys.UI.Control.prototype={_parent:null,_visibilityMode:Sys.UI.VisibilityMode.hide,get_element:function(){return this._element},get_id:function(){if(!this._element)return "";return this._element.id},set_id:function(){throw Error.invalidOperation(Sys.Res.cantSetId)},get_parent:function(){if(this._parent)return this._parent;if(!this._element)return null;var a=this._element.parentNode;while(a){if(a.control)return a.control;a=a.parentNode}return null},set_parent:function(a){this._parent=a},get_role:function(){return null},get_visibilityMode:function(){return Sys.UI.DomElement.getVisibilityMode(this._element)},set_visibilityMode:function(a){Sys.UI.DomElement.setVisibilityMode(this._element,a)},get_visible:function(){return Sys.UI.DomElement.getVisible(this._element)},set_visible:function(a){Sys.UI.DomElement.setVisible(this._element,a)},addCssClass:function(a){Sys.UI.DomElement.addCssClass(this._element,a)},dispose:function(){Sys.UI.Control.callBaseMethod(this,"dispose");if(this._element){this._element.control=null;delete this._element}if(this._parent)delete this._parent},onBubbleEvent:function(){return false},raiseBubbleEvent:function(a,b){this._raiseBubbleEvent(a,b)},_raiseBubbleEvent:function(b,c){var a=this.get_parent();while(a){if(a.onBubbleEvent(b,c))return;a=a.get_parent()}},removeCssClass:function(a){Sys.UI.DomElement.removeCssClass(this._element,a)},toggleCssClass:function(a){Sys.UI.DomElement.toggleCssClass(this._element,a)}};Sys.UI.Control.registerClass("Sys.UI.Control",Sys.Component);Sys.HistoryEventArgs=function(a){Sys.HistoryEventArgs.initializeBase(this);this._state=a};Sys.HistoryEventArgs.prototype={get_state:function(){return this._state}};Sys.HistoryEventArgs.registerClass("Sys.HistoryEventArgs",Sys.EventArgs);Sys.Application._appLoadHandler=null;Sys.Application._beginRequestHandler=null;Sys.Application._clientId=null;Sys.Application._currentEntry="";Sys.Application._endRequestHandler=null;Sys.Application._history=null;Sys.Application._enableHistory=false;Sys.Application._historyFrame=null;Sys.Application._historyInitialized=false;Sys.Application._historyPointIsNew=false;Sys.Application._ignoreTimer=false;Sys.Application._initialState=null;Sys.Application._state={};Sys.Application._timerCookie=0;Sys.Application._timerHandler=null;Sys.Application._uniqueId=null;Sys._Application.prototype.get_stateString=function(){var a=null;if(Sys.Browser.agent===Sys.Browser.Firefox){var c=window.location.href,b=c.indexOf("#");if(b!==-1)a=c.substring(b+1);else a="";return a}else a=window.location.hash;if(a.length>0&&a.charAt(0)==="#")a=a.substring(1);return a};Sys._Application.prototype.get_enableHistory=function(){return this._enableHistory};Sys._Application.prototype.set_enableHistory=function(a){this._enableHistory=a};Sys._Application.prototype.add_navigate=function(a){this.get_events().addHandler("navigate",a)};Sys._Application.prototype.remove_navigate=function(a){this.get_events().removeHandler("navigate",a)};Sys._Application.prototype.addHistoryPoint=function(c,f){this._ensureHistory();var b=this._state;for(var a in c){var d=c[a];if(d===null){if(typeof b[a]!=="undefined")delete b[a]}else b[a]=d}var e=this._serializeState(b);this._historyPointIsNew=true;this._setState(e,f);this._raiseNavigate()};Sys._Application.prototype.setServerId=function(a,b){this._clientId=a;this._uniqueId=b};Sys._Application.prototype.setServerState=function(a){this._ensureHistory();this._state.__s=a;this._updateHiddenField(a)};Sys._Application.prototype._deserializeState=function(a){var e={};a=a||"";var b=a.indexOf("&&");if(b!==-1&&b+2<a.length){e.__s=a.substr(b+2);a=a.substr(0,b)}var g=a.split("&");for(var f=0,j=g.length;f<j;f++){var d=g[f],c=d.indexOf("=");if(c!==-1&&c+1<d.length){var i=d.substr(0,c),h=d.substr(c+1);e[i]=decodeURIComponent(h)}}return e};Sys._Application.prototype._enableHistoryInScriptManager=function(){this._enableHistory=true};Sys._Application.prototype._ensureHistory=function(){if(!this._historyInitialized&&this._enableHistory){if(Sys.Browser.agent===Sys.Browser.InternetExplorer&&Sys.Browser.documentMode<8){this._historyFrame=document.getElementById("__historyFrame");this._ignoreIFrame=true}this._timerHandler=Function.createDelegate(this,this._onIdle);this._timerCookie=window.setTimeout(this._timerHandler,100);try{this._initialState=this._deserializeState(this.get_stateString())}catch(a){}this._historyInitialized=true}};Sys._Application.prototype._navigate=function(c){this._ensureHistory();var b=this._deserializeState(c);if(this._uniqueId){var d=this._state.__s||"",a=b.__s||"";if(a!==d){this._updateHiddenField(a);__doPostBack(this._uniqueId,a);this._state=b;return}}this._setState(c);this._state=b;this._raiseNavigate()};Sys._Application.prototype._onIdle=function(){delete this._timerCookie;var a=this.get_stateString();if(a!==this._currentEntry){if(!this._ignoreTimer){this._historyPointIsNew=false;this._navigate(a)}}else this._ignoreTimer=false;this._timerCookie=window.setTimeout(this._timerHandler,100)};Sys._Application.prototype._onIFrameLoad=function(a){this._ensureHistory();if(!this._ignoreIFrame){this._historyPointIsNew=false;this._navigate(a)}this._ignoreIFrame=false};Sys._Application.prototype._onPageRequestManagerBeginRequest=function(){this._ignoreTimer=true;this._originalTitle=document.title};Sys._Application.prototype._onPageRequestManagerEndRequest=function(g,f){var d=f.get_dataItems()[this._clientId],c=this._originalTitle;this._originalTitle=null;var b=document.getElementById("__EVENTTARGET");if(b&&b.value===this._uniqueId)b.value="";if(typeof d!=="undefined"){this.setServerState(d);this._historyPointIsNew=true}else this._ignoreTimer=false;var a=this._serializeState(this._state);if(a!==this._currentEntry){this._ignoreTimer=true;if(typeof c==="string"){if(Sys.Browser.agent!==Sys.Browser.InternetExplorer||Sys.Browser.version>7){var e=document.title;document.title=c;this._setState(a);document.title=e}else this._setState(a);this._raiseNavigate()}else{this._setState(a);this._raiseNavigate()}}};Sys._Application.prototype._raiseNavigate=function(){var d=this._historyPointIsNew,c=this.get_events().getHandler("navigate"),b={};for(var a in this._state)if(a!=="__s")b[a]=this._state[a];var e=new Sys.HistoryEventArgs(b);if(c)c(this,e);if(!d){var f;try{if(Sys.Browser.agent===Sys.Browser.Firefox&&window.location.hash&&(!window.frameElement||window.top.location.hash))Sys.Browser.version<3.5?window.history.go(0):(location.hash=this.get_stateString())}catch(g){}}};Sys._Application.prototype._serializeState=function(d){var b=[];for(var a in d){var e=d[a];if(a==="__s")var c=e;else b[b.length]=a+"="+encodeURIComponent(e)}return b.join("&")+(c?"&&"+c:"")};Sys._Application.prototype._setState=function(a,b){if(this._enableHistory){a=a||"";if(a!==this._currentEntry){if(window.theForm){var d=window.theForm.action,e=d.indexOf("#");window.theForm.action=(e!==-1?d.substring(0,e):d)+"#"+a}if(this._historyFrame&&this._historyPointIsNew){this._ignoreIFrame=true;var c=this._historyFrame.contentWindow.document;c.open("javascript:'<html></html>'");c.write("<html><head><title>"+(b||document.title)+"</title><scri"+'pt type="text/javascript">parent.Sys.Application._onIFrameLoad('+Sys.Serialization.JavaScriptSerializer.serialize(a)+");</scri"+"pt></head><body></body></html>");c.close()}this._ignoreTimer=false;this._currentEntry=a;if(this._historyFrame||this._historyPointIsNew){var f=this.get_stateString();if(a!==f){window.location.hash=a;this._currentEntry=this.get_stateString();if(typeof b!=="undefined"&&b!==null)document.title=b}}this._historyPointIsNew=false}}};Sys._Application.prototype._updateHiddenField=function(b){if(this._clientId){var a=document.getElementById(this._clientId);if(a)a.value=b}};if(!window.XMLHttpRequest)window.XMLHttpRequest=function(){var b=["Msxml2.XMLHTTP.3.0","Msxml2.XMLHTTP"];for(var a=0,c=b.length;a<c;a++)try{return new ActiveXObject(b[a])}catch(d){}return null};Type.registerNamespace("Sys.Net");Sys.Net.WebRequestExecutor=function(){this._webRequest=null;this._resultObject=null};Sys.Net.WebRequestExecutor.prototype={get_webRequest:function(){return this._webRequest},_set_webRequest:function(a){this._webRequest=a},get_started:function(){throw Error.notImplemented()},get_responseAvailable:function(){throw Error.notImplemented()},get_timedOut:function(){throw Error.notImplemented()},get_aborted:function(){throw Error.notImplemented()},get_responseData:function(){throw Error.notImplemented()},get_statusCode:function(){throw Error.notImplemented()},get_statusText:function(){throw Error.notImplemented()},get_xml:function(){throw Error.notImplemented()},get_object:function(){if(!this._resultObject)this._resultObject=Sys.Serialization.JavaScriptSerializer.deserialize(this.get_responseData());return this._resultObject},executeRequest:function(){throw Error.notImplemented()},abort:function(){throw Error.notImplemented()},getResponseHeader:function(){throw Error.notImplemented()},getAllResponseHeaders:function(){throw Error.notImplemented()}};Sys.Net.WebRequestExecutor.registerClass("Sys.Net.WebRequestExecutor");Sys.Net.XMLDOM=function(d){if(!window.DOMParser){var c=["Msxml2.DOMDocument.3.0","Msxml2.DOMDocument"];for(var b=0,f=c.length;b<f;b++)try{var a=new ActiveXObject(c[b]);a.async=false;a.loadXML(d);a.setProperty("SelectionLanguage","XPath");return a}catch(g){}}else try{var e=new window.DOMParser;return e.parseFromString(d,"text/xml")}catch(g){}return null};Sys.Net.XMLHttpExecutor=function(){Sys.Net.XMLHttpExecutor.initializeBase(this);var a=this;this._xmlHttpRequest=null;this._webRequest=null;this._responseAvailable=false;this._timedOut=false;this._timer=null;this._aborted=false;this._started=false;this._onReadyStateChange=function(){if(a._xmlHttpRequest.readyState===4){try{if(typeof a._xmlHttpRequest.status==="undefined")return}catch(b){return}a._clearTimer();a._responseAvailable=true;try{a._webRequest.completed(Sys.EventArgs.Empty)}finally{if(a._xmlHttpRequest!=null){a._xmlHttpRequest.onreadystatechange=Function.emptyMethod;a._xmlHttpRequest=null}}}};this._clearTimer=function(){if(a._timer!=null){window.clearTimeout(a._timer);a._timer=null}};this._onTimeout=function(){if(!a._responseAvailable){a._clearTimer();a._timedOut=true;a._xmlHttpRequest.onreadystatechange=Function.emptyMethod;a._xmlHttpRequest.abort();a._webRequest.completed(Sys.EventArgs.Empty);a._xmlHttpRequest=null}}};Sys.Net.XMLHttpExecutor.prototype={get_timedOut:function(){return this._timedOut},get_started:function(){return this._started},get_responseAvailable:function(){return this._responseAvailable},get_aborted:function(){return this._aborted},executeRequest:function(){this._webRequest=this.get_webRequest();var c=this._webRequest.get_body(),a=this._webRequest.get_headers();this._xmlHttpRequest=new XMLHttpRequest;this._xmlHttpRequest.onreadystatechange=this._onReadyStateChange;var e=this._webRequest.get_httpVerb();this._xmlHttpRequest.open(e,this._webRequest.getResolvedUrl(),true);this._xmlHttpRequest.setRequestHeader("X-Requested-With","XMLHttpRequest");if(a)for(var b in a){var f=a[b];if(typeof f!=="function")this._xmlHttpRequest.setRequestHeader(b,f)}if(e.toLowerCase()==="post"){if(a===null||!a["Content-Type"])this._xmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=utf-8");if(!c)c=""}var d=this._webRequest.get_timeout();if(d>0)this._timer=window.setTimeout(Function.createDelegate(this,this._onTimeout),d);this._xmlHttpRequest.send(c);this._started=true},getResponseHeader:function(b){var a;try{a=this._xmlHttpRequest.getResponseHeader(b)}catch(c){}if(!a)a="";return a},getAllResponseHeaders:function(){return this._xmlHttpRequest.getAllResponseHeaders()},get_responseData:function(){return this._xmlHttpRequest.responseText},get_statusCode:function(){var a=0;try{a=this._xmlHttpRequest.status}catch(b){}return a},get_statusText:function(){return this._xmlHttpRequest.statusText},get_xml:function(){var a=this._xmlHttpRequest.responseXML;if(!a||!a.documentElement){a=Sys.Net.XMLDOM(this._xmlHttpRequest.responseText);if(!a||!a.documentElement)return null}else if(navigator.userAgent.indexOf("MSIE")!==-1)a.setProperty("SelectionLanguage","XPath");if(a.documentElement.namespaceURI==="http://www.mozilla.org/newlayout/xml/parsererror.xml"&&a.documentElement.tagName==="parsererror")return null;if(a.documentElement.firstChild&&a.documentElement.firstChild.tagName==="parsererror")return null;return a},abort:function(){if(this._aborted||this._responseAvailable||this._timedOut)return;this._aborted=true;this._clearTimer();if(this._xmlHttpRequest&&!this._responseAvailable){this._xmlHttpRequest.onreadystatechange=Function.emptyMethod;this._xmlHttpRequest.abort();this._xmlHttpRequest=null;this._webRequest.completed(Sys.EventArgs.Empty)}}};Sys.Net.XMLHttpExecutor.registerClass("Sys.Net.XMLHttpExecutor",Sys.Net.WebRequestExecutor);Sys.Net._WebRequestManager=function(){this._defaultTimeout=0;this._defaultExecutorType="Sys.Net.XMLHttpExecutor"};Sys.Net._WebRequestManager.prototype={add_invokingRequest:function(a){this._get_eventHandlerList().addHandler("invokingRequest",a)},remove_invokingRequest:function(a){this._get_eventHandlerList().removeHandler("invokingRequest",a)},add_completedRequest:function(a){this._get_eventHandlerList().addHandler("completedRequest",a)},remove_completedRequest:function(a){this._get_eventHandlerList().removeHandler("completedRequest",a)},_get_eventHandlerList:function(){if(!this._events)this._events=new Sys.EventHandlerList;return this._events},get_defaultTimeout:function(){return this._defaultTimeout},set_defaultTimeout:function(a){this._defaultTimeout=a},get_defaultExecutorType:function(){return this._defaultExecutorType},set_defaultExecutorType:function(a){this._defaultExecutorType=a},executeRequest:function(webRequest){var executor=webRequest.get_executor();if(!executor){var failed=false;try{var executorType=eval(this._defaultExecutorType);executor=new executorType}catch(a){failed=true}webRequest.set_executor(executor)}if(executor.get_aborted())return;var evArgs=new Sys.Net.NetworkRequestEventArgs(webRequest),handler=this._get_eventHandlerList().getHandler("invokingRequest");if(handler)handler(this,evArgs);if(!evArgs.get_cancel())executor.executeRequest()}};Sys.Net._WebRequestManager.registerClass("Sys.Net._WebRequestManager");Sys.Net.WebRequestManager=new Sys.Net._WebRequestManager;Sys.Net.NetworkRequestEventArgs=function(a){Sys.Net.NetworkRequestEventArgs.initializeBase(this);this._webRequest=a};Sys.Net.NetworkRequestEventArgs.prototype={get_webRequest:function(){return this._webRequest}};Sys.Net.NetworkRequestEventArgs.registerClass("Sys.Net.NetworkRequestEventArgs",Sys.CancelEventArgs);Sys.Net.WebRequest=function(){this._url="";this._headers={};this._body=null;this._userContext=null;this._httpVerb=null;this._executor=null;this._invokeCalled=false;this._timeout=0};Sys.Net.WebRequest.prototype={add_completed:function(a){this._get_eventHandlerList().addHandler("completed",a)},remove_completed:function(a){this._get_eventHandlerList().removeHandler("completed",a)},completed:function(b){var a=Sys.Net.WebRequestManager._get_eventHandlerList().getHandler("completedRequest");if(a)a(this._executor,b);a=this._get_eventHandlerList().getHandler("completed");if(a)a(this._executor,b)},_get_eventHandlerList:function(){if(!this._events)this._events=new Sys.EventHandlerList;return this._events},get_url:function(){return this._url},set_url:function(a){this._url=a},get_headers:function(){return this._headers},get_httpVerb:function(){if(this._httpVerb===null){if(this._body===null)return "GET";return "POST"}return this._httpVerb},set_httpVerb:function(a){this._httpVerb=a},get_body:function(){return this._body},set_body:function(a){this._body=a},get_userContext:function(){return this._userContext},set_userContext:function(a){this._userContext=a},get_executor:function(){return this._executor},set_executor:function(a){this._executor=a;this._executor._set_webRequest(this)},get_timeout:function(){if(this._timeout===0)return Sys.Net.WebRequestManager.get_defaultTimeout();return this._timeout},set_timeout:function(a){this._timeout=a},getResolvedUrl:function(){return Sys.Net.WebRequest._resolveUrl(this._url)},invoke:function(){Sys.Net.WebRequestManager.executeRequest(this);this._invokeCalled=true}};Sys.Net.WebRequest._resolveUrl=function(b,a){if(b&&b.indexOf("://")!==-1)return b;if(!a||a.length===0){var d=document.getElementsByTagName("base")[0];if(d&&d.href&&d.href.length>0)a=d.href;else a=document.URL}var c=a.indexOf("?");if(c!==-1)a=a.substr(0,c);c=a.indexOf("#");if(c!==-1)a=a.substr(0,c);a=a.substr(0,a.lastIndexOf("/")+1);if(!b||b.length===0)return a;if(b.charAt(0)==="/"){var e=a.indexOf("://"),g=a.indexOf("/",e+3);return a.substr(0,g)+b}else{var f=a.lastIndexOf("/");return a.substr(0,f+1)+b}};Sys.Net.WebRequest._createQueryString=function(c,b,f){b=b||encodeURIComponent;var h=0,e,g,d,a=new Sys.StringBuilder;if(c)for(d in c){e=c[d];if(typeof e==="function")continue;g=Sys.Serialization.JavaScriptSerializer.serialize(e);if(h++)a.append("&");a.append(d);a.append("=");a.append(b(g))}if(f){if(h)a.append("&");a.append(f)}return a.toString()};Sys.Net.WebRequest._createUrl=function(a,b,c){if(!b&&!c)return a;var d=Sys.Net.WebRequest._createQueryString(b,null,c);return d.length?a+(a&&a.indexOf("?")>=0?"&":"?")+d:a};Sys.Net.WebRequest.registerClass("Sys.Net.WebRequest");Sys._ScriptLoaderTask=function(b,a){this._scriptElement=b;this._completedCallback=a};Sys._ScriptLoaderTask.prototype={get_scriptElement:function(){return this._scriptElement},dispose:function(){if(this._disposed)return;this._disposed=true;this._removeScriptElementHandlers();Sys._ScriptLoaderTask._clearScript(this._scriptElement);this._scriptElement=null},execute:function(){this._addScriptElementHandlers();document.getElementsByTagName("head")[0].appendChild(this._scriptElement)},_addScriptElementHandlers:function(){this._scriptLoadDelegate=Function.createDelegate(this,this._scriptLoadHandler);if(Sys.Browser.agent!==Sys.Browser.InternetExplorer){this._scriptElement.readyState="loaded";$addHandler(this._scriptElement,"load",this._scriptLoadDelegate)}else $addHandler(this._scriptElement,"readystatechange",this._scriptLoadDelegate);if(this._scriptElement.addEventListener){this._scriptErrorDelegate=Function.createDelegate(this,this._scriptErrorHandler);this._scriptElement.addEventListener("error",this._scriptErrorDelegate,false)}},_removeScriptElementHandlers:function(){if(this._scriptLoadDelegate){var a=this.get_scriptElement();if(Sys.Browser.agent!==Sys.Browser.InternetExplorer)$removeHandler(a,"load",this._scriptLoadDelegate);else $removeHandler(a,"readystatechange",this._scriptLoadDelegate);if(this._scriptErrorDelegate){this._scriptElement.removeEventListener("error",this._scriptErrorDelegate,false);this._scriptErrorDelegate=null}this._scriptLoadDelegate=null}},_scriptErrorHandler:function(){if(this._disposed)return;this._completedCallback(this.get_scriptElement(),false)},_scriptLoadHandler:function(){if(this._disposed)return;var a=this.get_scriptElement();if(a.readyState!=="loaded"&&a.readyState!=="complete")return;this._completedCallback(a,true)}};Sys._ScriptLoaderTask.registerClass("Sys._ScriptLoaderTask",null,Sys.IDisposable);Sys._ScriptLoaderTask._clearScript=function(a){if(!Sys.Debug.isDebug)a.parentNode.removeChild(a)};Type.registerNamespace("Sys.Net");Sys.Net.WebServiceProxy=function(){};Sys.Net.WebServiceProxy.prototype={get_timeout:function(){return this._timeout||0},set_timeout:function(a){if(a<0)throw Error.argumentOutOfRange("value",a,Sys.Res.invalidTimeout);this._timeout=a},get_defaultUserContext:function(){return typeof this._userContext==="undefined"?null:this._userContext},set_defaultUserContext:function(a){this._userContext=a},get_defaultSucceededCallback:function(){return this._succeeded||null},set_defaultSucceededCallback:function(a){this._succeeded=a},get_defaultFailedCallback:function(){return this._failed||null},set_defaultFailedCallback:function(a){this._failed=a},get_enableJsonp:function(){return !!this._jsonp},set_enableJsonp:function(a){this._jsonp=a},get_path:function(){return this._path||null},set_path:function(a){this._path=a},get_jsonpCallbackParameter:function(){return this._callbackParameter||"callback"},set_jsonpCallbackParameter:function(a){this._callbackParameter=a},_invoke:function(d,e,g,f,c,b,a){c=c||this.get_defaultSucceededCallback();b=b||this.get_defaultFailedCallback();if(a===null||typeof a==="undefined")a=this.get_defaultUserContext();return Sys.Net.WebServiceProxy.invoke(d,e,g,f,c,b,a,this.get_timeout(),this.get_enableJsonp(),this.get_jsonpCallbackParameter())}};Sys.Net.WebServiceProxy.registerClass("Sys.Net.WebServiceProxy");Sys.Net.WebServiceProxy.invoke=function(q,a,m,l,j,b,g,e,w,p){var i=w!==false?Sys.Net.WebServiceProxy._xdomain.exec(q):null,c,n=i&&i.length===3&&(i[1]!==location.protocol||i[2]!==location.host);m=n||m;if(n){p=p||"callback";c="_jsonp"+Sys._jsonp++}if(!l)l={};var r=l;if(!m||!r)r={};var s,h,f=null,k,o=null,u=Sys.Net.WebRequest._createUrl(a?q+"/"+encodeURIComponent(a):q,r,n?p+"=Sys."+c:null);if(n){s=document.createElement("script");s.src=u;k=new Sys._ScriptLoaderTask(s,function(d,b){if(!b||c)t({Message:String.format(Sys.Res.webServiceFailedNoMsg,a)},-1)});function v(){if(f===null)return;f=null;h=new Sys.Net.WebServiceError(true,String.format(Sys.Res.webServiceTimedOut,a));k.dispose();delete Sys[c];if(b)b(h,g,a)}function t(d,e){if(f!==null){window.clearTimeout(f);f=null}k.dispose();delete Sys[c];c=null;if(typeof e!=="undefined"&&e!==200){if(b){h=new Sys.Net.WebServiceError(false,d.Message||String.format(Sys.Res.webServiceFailedNoMsg,a),d.StackTrace||null,d.ExceptionType||null,d);h._statusCode=e;b(h,g,a)}}else if(j)j(d,g,a)}Sys[c]=t;e=e||Sys.Net.WebRequestManager.get_defaultTimeout();if(e>0)f=window.setTimeout(v,e);k.execute();return null}var d=new Sys.Net.WebRequest;d.set_url(u);d.get_headers()["Content-Type"]="application/json; charset=utf-8";if(!m){o=Sys.Serialization.JavaScriptSerializer.serialize(l);if(o==="{}")o=""}d.set_body(o);d.add_completed(x);if(e&&e>0)d.set_timeout(e);d.invoke();function x(d){if(d.get_responseAvailable()){var f=d.get_statusCode(),c=null;try{var e=d.getResponseHeader("Content-Type");if(e.startsWith("application/json"))c=d.get_object();else if(e.startsWith("text/xml"))c=d.get_xml();else c=d.get_responseData()}catch(m){}var k=d.getResponseHeader("jsonerror"),h=k==="true";if(h){if(c)c=new Sys.Net.WebServiceError(false,c.Message,c.StackTrace,c.ExceptionType,c)}else if(e.startsWith("application/json"))c=!c||typeof c.d==="undefined"?c:c.d;if(f<200||f>=300||h){if(b){if(!c||!h)c=new Sys.Net.WebServiceError(false,String.format(Sys.Res.webServiceFailedNoMsg,a));c._statusCode=f;b(c,g,a)}}else if(j)j(c,g,a)}else{var i;if(d.get_timedOut())i=String.format(Sys.Res.webServiceTimedOut,a);else i=String.format(Sys.Res.webServiceFailedNoMsg,a);if(b)b(new Sys.Net.WebServiceError(d.get_timedOut(),i,"",""),g,a)}}return d};Sys.Net.WebServiceProxy._generateTypedConstructor=function(a){return function(b){if(b)for(var c in b)this[c]=b[c];this.__type=a}};Sys._jsonp=0;Sys.Net.WebServiceProxy._xdomain=/^\s*([a-zA-Z0-9\+\-\.]+\:)\/\/([^?#\/]+)/;Sys.Net.WebServiceError=function(d,e,c,a,b){this._timedOut=d;this._message=e;this._stackTrace=c;this._exceptionType=a;this._errorObject=b;this._statusCode=-1};Sys.Net.WebServiceError.prototype={get_timedOut:function(){return this._timedOut},get_statusCode:function(){return this._statusCode},get_message:function(){return this._message},get_stackTrace:function(){return this._stackTrace||""},get_exceptionType:function(){return this._exceptionType||""},get_errorObject:function(){return this._errorObject||null}};Sys.Net.WebServiceError.registerClass("Sys.Net.WebServiceError");
Type.registerNamespace('Sys');Sys.Res={'argumentInteger':'Value must be an integer.','invokeCalledTwice':'Cannot call invoke more than once.','webServiceFailed':'The server method \'{0}\' failed with the following error: {1}','argumentType':'Object cannot be converted to the required type.','argumentNull':'Value cannot be null.','scriptAlreadyLoaded':'The script \'{0}\' has been referenced multiple times. If referencing Microsoft AJAX scripts explicitly, set the MicrosoftAjaxMode property of the ScriptManager to Explicit.','scriptDependencyNotFound':'The script \'{0}\' failed to load because it is dependent on script \'{1}\'.','formatBadFormatSpecifier':'Format specifier was invalid.','requiredScriptReferenceNotIncluded':'\'{0}\' requires that you have included a script reference to \'{1}\'.','webServiceFailedNoMsg':'The server method \'{0}\' failed.','argumentDomElement':'Value must be a DOM element.','invalidExecutorType':'Could not create a valid Sys.Net.WebRequestExecutor from: {0}.','cannotCallBeforeResponse':'Cannot call {0} when responseAvailable is false.','actualValue':'Actual value was {0}.','enumInvalidValue':'\'{0}\' is not a valid value for enum {1}.','scriptLoadFailed':'The script \'{0}\' could not be loaded.','parameterCount':'Parameter count mismatch.','cannotDeserializeEmptyString':'Cannot deserialize empty string.','formatInvalidString':'Input string was not in a correct format.','invalidTimeout':'Value must be greater than or equal to zero.','cannotAbortBeforeStart':'Cannot abort when executor has not started.','argument':'Value does not fall within the expected range.','cannotDeserializeInvalidJson':'Cannot deserialize. The data does not correspond to valid JSON.','invalidHttpVerb':'httpVerb cannot be set to an empty or null string.','nullWebRequest':'Cannot call executeRequest with a null webRequest.','eventHandlerInvalid':'Handler was not added through the Sys.UI.DomEvent.addHandler method.','cannotSerializeNonFiniteNumbers':'Cannot serialize non finite numbers.','argumentUndefined':'Value cannot be undefined.','webServiceInvalidReturnType':'The server method \'{0}\' returned an invalid type. Expected type: {1}','servicePathNotSet':'The path to the web service has not been set.','argumentTypeWithTypes':'Object of type \'{0}\' cannot be converted to type \'{1}\'.','cannotCallOnceStarted':'Cannot call {0} once started.','badBaseUrl1':'Base URL does not contain ://.','badBaseUrl2':'Base URL does not contain another /.','badBaseUrl3':'Cannot find last / in base URL.','setExecutorAfterActive':'Cannot set executor after it has become active.','paramName':'Parameter name: {0}','nullReferenceInPath':'Null reference while evaluating data path: \'{0}\'.','cannotCallOutsideHandler':'Cannot call {0} outside of a completed event handler.','cannotSerializeObjectWithCycle':'Cannot serialize object with cyclic reference within child properties.','format':'One of the identified items was in an invalid format.','assertFailedCaller':'Assertion Failed: {0}\r\nat {1}','argumentOutOfRange':'Specified argument was out of the range of valid values.','webServiceTimedOut':'The server method \'{0}\' timed out.','notImplemented':'The method or operation is not implemented.','assertFailed':'Assertion Failed: {0}','invalidOperation':'Operation is not valid due to the current state of the object.','breakIntoDebugger':'{0}\r\n\r\nBreak into debugger?'};
Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._Common = function()
{
    this.getStyleForElement = function(element)
    {
        var visibleStyle = element.currentStyle; //IE only
        if (!visibleStyle)
        {
            if (document.defaultView && document.defaultView.getComputedStyle) //Firefox only
                visibleStyle = document.defaultView.getComputedStyle(element, "");
            else
                visibleStyle = element.style;
        }

        return visibleStyle;
    },

    this.getComputedStyle = function(element, styleName)
    {
        // Retrieve the cascaded direction attribute/style.
        // The currentStyle property is supported by IE.
        // Other browsers (Firefox, Safari) must use the
        // getComputedStyle method.
        if (element.currentStyle != null)
        {
            // converts for ex. border-left-width in borderLeftWidth
            styleName = styleName.replace(/-\D/gi, function(s) { return s.charAt(s.length - 1).toUpperCase(); });
            return element.currentStyle[styleName];
        }
        else if (window.getComputedStyle != null)
        {
            var cs = window.getComputedStyle(element, null);
            return cs.getPropertyValue(styleName);
        }
        return null;
    },

    this.getPxPerInch = function()
    {
        if (!this.DPI)
        {
            this.DPI = Microsoft_ReportingServices_HTMLRenderer_PxPerInch();
        }
        return this.DPI;
    },

    this.convertToPx = function(value)
    {
        if (!value)
            return 0;
        var lowerValue = value.toString().toLowerCase();
        if (lowerValue.indexOf("pt") > -1)
        {
            return Math.ceil(parseInt(value) / 72 * this.getPxPerInch());
        }
        else if (lowerValue.indexOf("px") > -1)
        {
            return parseInt(value);
        }
        return 0;
    },

    this.windowRect = function()
    {
        var docElementWidth = document.documentElement && document.documentElement.clientWidth ? document.documentElement : document.body;
        var docElementScroll = document.documentElement && document.documentElement.scrollLeft ? document.documentElement : document.body;

        var windowWidth = window.innerWidth != null ? window.innerWidth : docElementWidth ? docElementWidth.clientWidth : 0;
        var windowHeight = window.innerHeight != null ? window.innerHeight : docElementWidth ? docElementWidth.clientHeight : 0;
        var windowLeft = typeof (window.pageXOffset) != 'undefined' ? window.pageXOffset : docElementScroll ? docElementScroll.scrollLeft : 0;
        var windowTop = typeof (window.pageYOffset) != 'undefined' ? window.pageYOffset : docElementScroll ? docElementScroll.scrollTop : 0;

        var windowScrollWidth = docElementScroll ? docElementScroll.scrollWidth : 0;
        var windowScrollHeight = docElementScroll ? docElementScroll.scrollHeight : 0;

        var isVScroll = Sys.Browser.agent == Sys.Browser.InternetExplorer ? false : windowHeight < windowScrollHeight;
        var isHScroll = Sys.Browser.agent == Sys.Browser.InternetExplorer ? false : windowWidth < windowScrollWidth;

        return {
            top: windowTop,
            left: windowLeft,
            bottom: windowTop + windowHeight - (isHScroll ? 18 : 0),
            right: windowLeft + windowWidth - (isVScroll ? 18 : 0),
            width: windowWidth,
            height: windowHeight,
            scrollWidth: Math.max(windowWidth, windowScrollWidth),
            scrollHeight: Math.max(windowHeight, windowScrollHeight),
            clientWidth: windowWidth - (isVScroll ? 18 : 0),
            clientHeight: windowHeight - (isHScroll ? 18 : 0)
        };
    },

    this.isQuirksMode = function()
    {
        // document.compatMode dom property now works for latest versions of safari/FF/IE.
        return document.compatMode == "BackCompat";
    },

    this.isSafari = function()
    {
        return Sys.Browser.agent == Sys.Browser.Safari;
    },

    this.isIEQuirksMode = function()
    {
        return Sys.Browser.agent == Sys.Browser.InternetExplorer && this.isQuirksMode();
    },

    this.isPreIE8StandardsMode = function()
    {
        if (Sys.Browser.agent != Sys.Browser.InternetExplorer)
            return false;

        if (Sys.Browser.version <= 7)
            return document.compatMode == "CSS1Compat";
        else
            return Sys.Browser.documentMode == 7; // See isIE8StandardMode for definition of documentMode
    },

    this.isIE8StandardsMode = function()
    {
        // documentMode is
        // 5 for quirks mode
        // 7 for IE7 standards mode
        // 8 for IE8 standards mode
        return Sys.Browser.agent == Sys.Browser.InternetExplorer && Sys.Browser.version >= 8 && Sys.Browser.documentMode == 8;
    },

    this.getDocument = function(element)
    {
        if (element)
            return element.ownerDocument || element.document || element;
        return document;
    },

    this.getWindow = function(element)
    {
        var doc = this.getDocument(element);
        return doc.defaultView || doc.parentWindow;
    },

    this.setButtonStyle = function(element, style, cursor)
    {
        if (style.CssClass)
        {
            element.className = style.CssClass;
        }
        else
        {
            element.style.border = style.Border;
            if (Sys.Browser.agent == Sys.Browser.InternetExplorer && Sys.Browser.version < 7)
            {
                if (element.style.borderColor.toLowerCase() == "transparent")
                {
                    element.style.padding = element.style.borderWidth;
                    element.style.border = "";
                }
                else
                    element.style.padding = "0px";
            }
            element.style.backgroundColor = style.Color;
            element.style.cursor = cursor;
        }
    },

    this.SetElementVisibility = function(element, makeVisible)
    {
        if (makeVisible)
            element.style.display = "";
        else
            element.style.display = "none";

    },

    this.documentOffset = function(element)
    {
        /// <summary>
        /// Returns the offset in pixels of the given element from the body
        /// </summary>

        if (!element || !element.ownerDocument)
        {
            throw Error.argumentNull("element");
        }

        var box = element.getBoundingClientRect();
        var doc = element.ownerDocument;
        var body = doc.body;
        var docElem = doc.documentElement;

        // docElem.clientTop = non IE, body.clientTop = IE
        var clientTop = docElem.clientTop || body.clientTop || 0;
        var clientLeft = docElem.clientLeft || body.clientLeft || 0;

        // pageX/YOffset = FF, safari   docElem.scrollTop/Left = IE standards   body.scrollTop/Left = IE quirks
        var top = box.top + (self.pageYOffset || docElem.scrollTop || body.scrollTop || 0) - clientTop;
        var left = box.left + (self.pageXOffset || docElem.scrollLeft || body.scrollLeft || 0) - clientLeft;

        return { top: top, left: left };
    },

    this.getBounds = function(element)
    {
        /// <summary>
        /// Returns the overall dimensions of an element: top and left offsets from the body,
        /// as well as the width and height of the element
        /// </summary>

        if (element == null)
        {
            throw Error.argumentNull("element");
        }

        var width = Math.max(this.getFloat(this.getComputedStyle(element, "width")), element.clientWidth);
        width += this.getFloat(element.style.marginLeft) + this.getFloat(element.style.marginRight);
        width += this.getFloat(element.style.borderLeftWidth) / 2.0 + this.getFloat(element.style.borderRightWidth) / 2.0;

        var height = Math.max(this.getFloat(this.getComputedStyle(element, "height")), element.clientHeight);
        height += this.getFloat(element.style.marginTop) + this.getFloat(element.style.marginBottom);
        height += this.getFloat(element.style.borderBottomWidth) / 2.0 + this.getFloat(element.style.borderTopWidth) / 2.0;

        var offset = this.documentOffset(element);

        return { left: offset.left, top: offset.top, width: Math.round(width), height: Math.round(height), right: offset.left + Math.round(width), bottom: offset.top + Math.round(height) };
    },

    this.getFloat = function(value)
    {
        /// <summary>
        /// Attempts to parse the incoming value into a float.
        /// If it can't, returns zero.
        /// </summary>

        var parsed = parseFloat(value);

        if (isNaN(parsed))
        {
            return 0;
        }

        return parsed;
    },

    this.getInt = function(value)
    {
        /// <summary>
        /// Attempts to parse the incoming value into an int.
        /// If it can't, returns zero.
        /// </summary>

        var parsed = parseInt(value);

        if (isNaN(parsed))
        {
            return 0;
        }

        return parsed;
    }
}

var _$RVCommon = new Microsoft.Reporting.WebFormsClient._Common();
Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._HoverImage = function(element)
{
    Microsoft.Reporting.WebFormsClient._HoverImage.initializeBase(this, [element]);

    this.OnClickScript = null;
    
    this.m_reportViewer = null;
    this.LTRImageID = null;
    this.RTLImageID = null;
}

Microsoft.Reporting.WebFormsClient._HoverImage.prototype = 
{
    initialize : function()
    {
        Microsoft.Reporting.WebFormsClient._HoverImage.callBaseMethod(this, "initialize");
        $addHandlers(this.get_element(),
            { "mouseover" : this.OnMouseOver,
              "mouseout"  : this.OnMouseOut,
              "click"     : this.OnClick },
            this);

        this.OnMouseOut(null);
        
        this.SetImageButton();
    },
    
    dispose : function()
    {   
        $clearHandlers(this.get_element());
        
        Microsoft.Reporting.WebFormsClient._HoverImage.callBaseMethod(this, "dispose");
    },
    
    set_NormalStyles: function(value) { this._normalStyles = value; },
    get_NormalStyles: function() { return this._normalStyles; },

    set_HoverStyles: function(value) { this._hoverStyles = value; },
    get_HoverStyles: function() { return this._hoverStyles; },
    
    set_ReportViewer : function(value)
    {
        this.m_reportViewer = value;
    },
    
    OnMouseOver : function(e)
    {
        if (this.OnClickScript == null)
            return;
        if (!this.IsButtonDisabled())
        {
            _$RVCommon.setButtonStyle(this.get_element(), this._hoverStyles, "pointer");
        }
    },

    OnMouseOut : function(e)
    {
        if (!this.IsButtonDisabled())
        {
            _$RVCommon.setButtonStyle(this.get_element(), this._normalStyles, "default");
        }
    },

    OnClick : function(e)
    {
        if(!this.IsButtonDisabled())
        {
            if (this.OnClickScript != null)
                this.OnClickScript();
        }
        
        e.preventDefault();
    },
    
    SetImageButton : function()
    {         
        if (this.m_reportViewer != null)
        {
            var direction = this.m_reportViewer._get_direction();
            
            var ltrImage = document.getElementById(this.LTRImageID);
            var rtlImage = document.getElementById(this.RTLImageID);
                       
            if (direction == "rtl")
            {
                rtlImage.style.display = "";
                ltrImage.style.display = "none";
            }
            else
            {
                rtlImage.style.display = "none";
                ltrImage.style.display = "";
            }
        }
    },
    
    IsButtonDisabled : function()
    {
        var button = this.get_element();
        var buttonDisabledValue;
        
        // Button is table element. The HoverImage renders Enabled=false as disabled="disabled" attribute.
        // Some of the browsers interpred this as boolean disabled property, but is not in the standard for table element. 
        if (typeof(button.disabled) != "undefined")
        {
            return button.disabled;
        }
        
        var buttonDisabledValue;
        if (button.attributes && (typeof(button.attributes["disabled"]) != "undefined"))
            buttonDisabledValue = button.attributes["disabled"].nodeValue;

        if (buttonDisabledValue == "disabled")
            return true;
        else
            return false;
    }
}

Microsoft.Reporting.WebFormsClient._HoverImage.registerClass("Microsoft.Reporting.WebFormsClient._HoverImage", Sys.UI.Control);
﻿Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._InternalReportViewer = function(element)
{
    Microsoft.Reporting.WebFormsClient._InternalReportViewer.initializeBase(this, [element]);

    this.ReportViewerId = null;
    this.ReportAreaId = null;
    this.DocMapAreaId = null;
    this.FixedTableId = null;

    this.ActionTypeId = null;
    this.ActionParamId = null;
    this.HasSizingRow = true;

    this.BaseHeight = null;
    this.BaseWidth = null;

    this.PromptAreaRowId = null;
    this.PromptSplitterId = null;
    this.DocMapSplitterId = null;
    this.DirectionCacheId = null;
    this.DocMapHeaderOverflowDivId = null;
    this.BrowserModeId = null;

    this.UnableToLoadPrintMessage = null;

    this.PostBackToClientScript = null;

    this.ExportUrlBase = null;
    this.m_printInfo = null;

    this.m_OnAppLoadDelegate = Function.createDelegate(this, this.OnAppLoad);
    this.m_OnReportAreaContentChangedDelegate = Function.createDelegate(this, this.OnReportAreaContentChanged);
    this.m_OnAsyncPostBackStartedDelegate = Function.createDelegate(this, this.OnAsyncPostBackStarted);
    this.m_OnAsyncPostBackEndedDelegate = Function.createDelegate(this, this.OnAsyncPostBackEnded);
    this.m_OnReportAreaScrollPositionChangedDelegate = Function.createDelegate(this, this.OnReportAreaScrollPositionChanged);
    this.m_OnWindowResizeDelegate = Function.createDelegate(this, this.OnWindowResize);
    this.m_PromptSplitterCollapsingDelegate = Function.createDelegate(this, this.OnPromptSplitterCollapsing);
    this.m_DocMapSplitterCollapsingDelegate = Function.createDelegate(this, this.OnDocMapSplitterCollapsing);
    this.m_DocMapSplitterResizingDelegate = Function.createDelegate(this, this.OnDocMapSplitterResizing);

    this.m_onAppLoadCalled = false;
    this.m_useResizeScript = false;
    this.m_reportViewer = null;
    this.m_isLoading = true;
    this.m_toolBarUpdate = {};
    this.m_reportAreaContentChanged = false;

    this.m_previousWindowHeight = -1;
    this.m_previousWindowWidth = -1;
}

Microsoft.Reporting.WebFormsClient._InternalReportViewer.prototype =
{
    initialize: function()
    {
        Microsoft.Reporting.WebFormsClient._InternalReportViewer.callBaseMethod(this, "initialize");
        Sys.Application.add_load(this.m_OnAppLoadDelegate);

        var isHeightPercentage = false;

        if (this.BaseHeight.indexOf('%') >= 0)
        {
            isHeightPercentage = true;
        }

        this.m_useResizeScript = !_$RVCommon.isIEQuirksMode() && parseFloat(this.BaseHeight) != 0 && this.HasSizingRow;

        if (this.m_useResizeScript)
        {
            $addHandler(window, "resize", this.m_OnWindowResizeDelegate);
        }
    },

    dispose: function()
    {
        Microsoft.Reporting.WebFormsClient._InternalReportViewer.callBaseMethod(this, "dispose");

        if (this.m_OnAppLoadDelegate != null)
        {
            Sys.Application.remove_load(this.m_OnAppLoadDelegate);
            delete this.m_OnAppLoadDelegate;
            this.m_OnAppLoadDelegate = null;
        }

        if (this.m_OnReportAreaContentChangedDelegate != null)
        {
            delete this.m_OnReportAreaContentChangedDelegate;
            this.m_OnReportAreaContentChangedDelegate = null;
        }

        if (this.m_OnAsyncPostBackStartedDelegate != null)
        {
            var pageRequestManager = this.GetPageRequestManager();
            if (pageRequestManager != null)
            {
                pageRequestManager.remove_beginRequest(this.m_OnAsyncPostBackStartedDelegate);
                pageRequestManager.remove_endRequest(this.m_OnAsyncPostBackEndedDelegate);
            }

            delete this.m_OnAsyncPostBackStartedDelegate;
            this.m_OnAsyncPostBackStartedDelegate = null;

            delete this.m_OnAsyncPostBackEndedDelegate;
            this.m_OnAsyncPostBackEndedDelegate = null;
        }

        if (this.m_OnReportAreaScrollPositionChangedDelegate != null)
        {
            delete this.m_OnReportAreaScrollPositionChangedDelegate;
            this.m_OnReportAreaScrollPositionChangedDelegate = null;
        }

        if (this.m_OnWindowResizeDelegate != null)
        {
            if (this.m_useResizeScript)
                $removeHandler(window, "resize", this.m_OnWindowResizeDelegate);

            delete this.m_OnWindowResizeDelegate;
            this.m_OnWindowResizeDelegate = null;
        }

        if (this._promptSplitter)
            this._promptSplitter.remove_collapsing(this.m_PromptSplitterCollapsingDelegate);
        delete this.m_PromptSplitterCollapsingDelegate;
        this.m_PromptSplitterCollapsingDelegate = null;

        if (this._docMapSplitter)
        {
            this._docMapSplitter.remove_collapsing(this.m_DocMapSplitterCollapsingDelegate);
            this._docMapSplitter.remove_resizing(this.m_DocMapSplitterResizingDelegate);
        }
        delete this.m_DocMapSplitterCollapsingDelegate;
        this.m_DocMapSplitterCollapsingDelegate = null;
        delete this.m_DocMapSplitterResizingDelegate;
        this.m_DocMapSplitterResizingDelegate = null;

        if (this._docMapCells != null)
        {
            delete this._docMapCells;
            this._docMapCells = null;
        }
    },

    ResetWindowSizeCache: function()
    {
        // this is to explicitly force HasWindowChangedSize
        // to return true, thus forcing the resize code to run in IE

        this.m_previousWindowHeight = -1;
        this.m_previousWindowWidth = -1;
    },

    // Custom accessor for complex object type (array)
    set_PrintInfo: function(value) { this.m_printInfo = value; },
    get_PrintInfo: function() { return this.m_printInfo; },

    OnAppLoad: function()
    {
        if (!this.m_onAppLoadCalled)
        {
            var reportAreaElement = $get(this.ReportAreaId);
            var reportAreaControl = reportAreaElement.control;
            reportAreaControl.add_contentChanged(this.m_OnReportAreaContentChangedDelegate);
            reportAreaControl.add_propertyChanged(this.m_OnReportAreaScrollPositionChangedDelegate);

            var pageRequestManager = this.GetPageRequestManager();
            if (pageRequestManager != null)
            {
                pageRequestManager.add_beginRequest(this.m_OnAsyncPostBackStartedDelegate);
                pageRequestManager.add_endRequest(this.m_OnAsyncPostBackEndedDelegate);
            }

            this.UpdateBrowserMode();
            this.m_onAppLoadCalled = true;
        }

        if (!this._promptSplitter)
        {
            this._promptSplitter = $get(this.PromptSplitterId).control;
            this._promptSplitter.add_collapsing(this.m_PromptSplitterCollapsingDelegate);
        }

        if (!this._docMapSplitter)
        {
            this._docMapSplitter = $get(this.DocMapSplitterId).control;
            this._docMapSplitter.add_collapsing(this.m_DocMapSplitterCollapsingDelegate);
            this._docMapSplitter.add_resizing(this.m_DocMapSplitterResizingDelegate);
        }

        if (this._docMapCells != null)
        {
            delete this._docMapCells;
            this._docMapCells = null;
        }

        this._UpdateDocMapAreaUIVisibility();

        this.ResizeViewerReportUsingContainingElement(false);

        // we want IE to call our resize code once again after the page has fully loaded
        this.ResetWindowSizeCache();

        this.HideSizingRow();
    },

    HideSizingRow: function()
    {
        // the row can only be hidden for IE quirks mode
        // Generally it can be hidden in pre IE8 standards mode, but this fails in the webpart
        if (this.HasSizingRow && _$RVCommon.isIEQuirksMode())
        {
            var fixedTable = $get(this.FixedTableId);
            var sizingRow = fixedTable.rows.item(0);
            sizingRow.style.display = "none";
        }
    },

    OnReportAreaContentChanged: function(sender, eventArgs)
    {
        this.m_toolBarUpdate = eventArgs.ToolBarUpdate;
        this.m_reportAreaContentChanged = true;

        if (this.get_reportAreaContentType() == Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage)
        {
            // bring the docmap into view now that the report is ready
            var docMap = $get(this.DocMapAreaId);
            _$RVCommon.SetElementVisibility(docMap, true);
            this._UpdateDocMapAreaUIVisibility();
        }

        // If the report loaded so quickly that the async request hasn't
        // finished yet, wait for it to complete before enabling things.
        var pageRequestManager = this.GetPageRequestManager();
        if (pageRequestManager == null || !pageRequestManager.get_isInAsyncPostBack())
            this.EnableDisableInput(true);
    },

    OnWindowResize: function()
    {
        this.ResizeViewerReportUsingContainingElement(false);
    },

    HasWindowChangedSize: function()
    {
        // this method is only relevant to IE
        if (Sys.Browser.agent != Sys.Browser.InternetExplorer)
        {
            // "true" esentially means "go ahead and run the resize code"
            return true;
        }

        var width = document.body.clientWidth;
        var height = document.body.clientHeight;

        var changed = width !== this.m_previousWindowWidth || height !== this.m_previousWindowHeight;

        this.m_previousWindowHeight = height;
        this.m_previousWindowWidth = width;

        return changed;
    },

    ResizeViewerReportUsingContainingElement: function(forceRecalculate)
    {
        var reportViewer = $get(this.ReportViewerId);
        var reportArea = $get(this.ReportAreaId);

        // It is possible for the window resize event to fire before everything is created.
        if (reportArea.control == null)
            return;

        // in IE, we only want to execute this code if the window has truly changed
        // size in most cases. That is what the HasWindowChangedSize checks for.
        // Otherwise IE will call the resize handler often, and our handler will cause
        // them to fire resize even more, leading to crashing the browser
        if (!forceRecalculate && (!this.m_useResizeScript || !this.HasWindowChangedSize()))
            return;

        var isHeightPercentage = false;

        if (this.BaseHeight.indexOf('%') >= 0)
        {
            isHeightPercentage = true;
        }

        var reportViewerHeight = -1;
        var reportAreaHeight = -1;

        if (isHeightPercentage)
        {
            var actualHeight = this.GetReportViewerHeight();
            reportViewerHeight = Math.round(((actualHeight) / 100) * parseFloat(this.BaseHeight));
        }
        else
        {
            reportViewerHeight = _$RVCommon.convertToPx(this.BaseHeight);
        }

        var toolbarHeight = this.GetFixedHeight();
        reportAreaHeight = reportViewerHeight - toolbarHeight;


        if ((reportViewerHeight == 0 && isHeightPercentage) ||
            reportViewerHeight < 0 ||
            reportAreaHeight < 0 ||
            (reportViewerHeight < reportAreaHeight))
        {
            // At least make the doc map the same height as the report area
            this.SetDocMapAreaHeight(reportArea.offsetHeight);
        }
        else
        {
            reportViewer.style.height = reportViewerHeight + "px";
            reportArea.parentNode.style.height = reportAreaHeight + "px";

            var visibleContainer = $get(reportArea.control.VisibleReportContentContainerId);
            if (visibleContainer && visibleContainer.style)
            {
                var visibleStyle = _$RVCommon.getStyleForElement(visibleContainer);

                //Take into consideration the borders and remove them from the width.  IE Standards mode, Firefox, and Safari need this
                var sumofborderHeight = _$RVCommon.convertToPx(visibleStyle.borderTopWidth)
                    + _$RVCommon.convertToPx(visibleStyle.borderBottomWidth);
                var sumofborderWidth = _$RVCommon.convertToPx(visibleStyle.borderLeftWidth)
                    + _$RVCommon.convertToPx(visibleStyle.borderRightWidth);

                if (sumofborderHeight > 0 || sumofborderWidth > 0)
                {
                    //Do not make the sizes less than the minimum of the data
                    var reportDivId = reportArea.control.GetReportPage().ReportDivId; //Use the oReportDiv/TABLE to calc the minimum sizing
                    var minHeight = reportDivId ? $get(reportDivId).childNodes[0].clientHeight : 0;
                    var minWidth = reportDivId ? $get(reportDivId).childNodes[0].clientWidth : 0;

                    //IE calculates the sizing to need scrollbars if the content is larger than the outer size.
                    //This makes the content start as zero.
                    visibleContainer.style.height = 0;
                    visibleContainer.style.width = 0;

                    var targetHeight = 0;
                    var targetWidth = 0;

                    //Make sure the visiblecontainer size is at least the size of the report content
                    if (sumofborderHeight > 0)
                        targetHeight = Math.max(reportArea.clientHeight - sumofborderHeight, minHeight);

                    if (sumofborderWidth > 0)
                        targetWidth = Math.max(reportArea.clientWidth - sumofborderWidth, minWidth);

                    if (targetHeight > 0)
                        visibleContainer.style.height = targetHeight + "px";
                    if (targetWidth > 0)
                        visibleContainer.style.width = targetWidth + "px";
                }
            }

            this.SetLastRowHeight(reportAreaHeight + "px");

            // Finally set the DocMapArea height.
            this.SetDocMapAreaHeight(reportAreaHeight);
        }

        // IE 7 standards mode - when the viewer is in an inline element and there is a doc map, IE
        // collapses the width of the entire viewer to the width of the splitter (the fixed width column).
        // To calculate the correct width in this case, hide the splitter and use the width that IE
        // assigns when only percentage width columns are visible.
        if (_$RVCommon.isPreIE8StandardsMode() &&   // IE 7 standards mode
            this.BaseWidth.indexOf('%') > 0 &&      // Percentage width
            this.HasSizingRow)                      // Not SizeToReportContent
        {
            // Hide the doc map
            this._UpdateDocMapAreaUIVisibility(true);

            // Revert viewer to its original value
            reportViewer.style.width = this.BaseWidth;

            // Calculate parent width and Set width on viewer
            reportViewer.style.width = reportViewer.clientWidth + "px";

            // Restore doc map
            this._UpdateDocMapAreaUIVisibility();
        }

        this._UpdateDocMapAreaUIWidth(Number.NaN);
    },

    SetLastRowHeight: function(height)
    {
        var result = null;
        var lastRow = $get(this.FixedTableId).rows.item(this.HasSizingRow ? 4 : 3);
        for (var cellIndex = 0; cellIndex < lastRow.cells.length; cellIndex++)
        {
            if (!result)
                result = lastRow.cells.item(cellIndex).style.height;
            lastRow.cells.item(cellIndex).style.height = height;
        }
        return result;
    },

    GetReportViewerHeight: function()
    {
        var reportArea = $get(this.ReportAreaId);
        var top = reportArea.scrollTop;
        var left = reportArea.scrollLeft;
        var docMap = this.GetDocMapCells();
        var docMapTop = 0;
        var docMapLeft = 0;
        if (docMap != null && docMap.docMapContainer != null)
        {
            docMapTop = docMap.docMapContainer.scrollTop;
            docMapLeft = docMap.docMapContainer.scrollLeft;
        }

        var reportViewer = $get(this.ReportViewerId);
        var height = 0;

        // Remember the current display style for the viewer
        var viewerDisplayStyle = reportViewer.style.display;
        var originalHeight = reportViewer.style.height;

        // Hide the viewer so it does not alter the dimensions of its parent.
        reportViewer.style.display = "none";

        // Set the viewer height back to its original value, otherwise fixed pixel height
        // will prevent the collapse we need for recalculation in non-IE browsers.
        reportViewer.style.height = this.BaseHeight;

        // The extra parentNode here is the update panel that encapsulates the reportViewer Control.
        height = reportViewer.parentNode.parentNode.clientHeight;

        // Make the viewer visible again.
        reportViewer.style.display = viewerDisplayStyle;
        reportViewer.style.height = originalHeight;

        if (top > 0 || left > 0)
        {
            // With the display = 'none' above, Firefox resets the scroll position.  Scroll back to the previous point.
            var currentTop = reportArea.scrollTop;
            var currentLeft = reportArea.scrollLeft;
            if (top != currentTop)
                reportArea.scrollTop = top;
            if (left != currentLeft)
                reportArea.scrollLeft = left;
        }

        if (docMapTop > 0 || docMapLeft > 0)
        {
            var currentTop = docMap.docMapContainer.scrollTop;
            var currentLeft = docMap.docMapContainer.scrollLeft;
            if (docMapTop != currentTop)
                docMap.docMapContainer.scrollTop = docMapTop;
            if (docMapLeft != currentLeft)
                docMap.docMapContainer.scrollLeft = docMapLeft;
        }

        return height;
    },

    GetFixedHeight: function()
    {
        var height = 0;

        var fixedTable = $get(this.FixedTableId);
        if (fixedTable != null)
        {
            // set last row height 100% so can push the upper rows up;
            // Preserve scroll position - this method should not alter the display
            var oldScrollPos = this.get_reportAreaScrollPosition();
            var oldHeight = this.SetLastRowHeight("100%")

            var rows = fixedTable.rows;

            // Get the offsetHeight of all the rows except the last one as that is the reportArea.
            // Accessing hidden offsetHeight row causes resize event in IE8 compat.
            for (var i = 0; i < (rows.length - 1); i++)
            {
                if (rows[i].style.display != "none")
                    height += rows[i].offsetHeight;
            }

            this.SetLastRowHeight(oldHeight);
            this.set_reportAreaScrollPosition(oldScrollPos);
        }

        return height;
    },

    OnAsyncPostBackStarted: function()
    {
        this.EnableDisableInput(false);
    },

    OnAsyncPostBackEnded: function()
    {
        var reportAreaElement = $get(this.ReportAreaId);
        var reportAreaControl = reportAreaElement.control;

        // Async postback disabled the toolbar.  If no new page was loaded (or
        // loading completed before the request ended), no report area load event
        // will follow, so set the toolbar back to enabled here.
        if (!reportAreaControl.IsLoading())
            this.EnableDisableInput(true);
    },

    get_isLoading: function()
    {
        return this.m_isLoading;
    },

    get_reportAreaScrollPosition: function()
    {
        var reportAreaElement = $get(this.ReportAreaId);
        var reportAreaControl = reportAreaElement.control;
        if (reportAreaControl != null)
            return reportAreaControl.get_scrollPosition();
        else
            return new Sys.UI.Point(0, 0);
    },

    set_reportAreaScrollPosition: function(scrollPoint)
    {
        var reportAreaElement = $get(this.ReportAreaId);
        var reportAreaControl = reportAreaElement.control;
        if (reportAreaControl != null)
            return reportAreaControl.set_scrollPosition(scrollPoint);
    },

    OnReportAreaScrollPositionChanged: function(sender, e)
    {
        if (e.get_propertyName() == "scrollPosition")
            this.raisePropertyChanged("reportAreaScrollPosition");
    },

    EnableDisableInput: function(shouldEnable)
    {
        if (this.m_isLoading == shouldEnable)
        {
            this.m_isLoading = !shouldEnable;
            this.raisePropertyChanged("isLoading");

            // Fire the report area content changed event
            if (this.m_reportAreaContentChanged)
            {
                this.raisePropertyChanged("reportAreaContentType");
                this.m_reportAreaContentChanged = false;
            }
        }

        // Enable/Disable various viewer regions.  If enabling and about to trigger a postback
        // (which would just disable things again), skip the enable.
        if (!shouldEnable || !Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.AsyncTriggerSelected)
        {
            var reportAreaElement = $get(this.ReportAreaId);
            if (reportAreaElement && reportAreaElement.control)
                reportAreaElement.control.EnableDisableInput(shouldEnable);
            this._promptSplitter.SetActive(shouldEnable);
            this._docMapSplitter.SetActive(shouldEnable);

            var docMap = $get(this.DocMapAreaId).control;
            if (docMap)
                docMap.SetActive(shouldEnable);
        }

        this.ResizeViewerReportUsingContainingElement(false);
    },

    add_reportContentLoaded: function(handler)
    {
        var reportAreaElement = $get(this.ReportAreaId);
        var reportAreaControl = reportAreaElement.control;
        reportAreaControl.add_reportContentLoaded(handler);
    },

    remove_reportContentLoaded: function(handler)
    {
        var reportAreaElement = $get(this.ReportAreaId);
        var reportAreaControl = reportAreaElement.control;
        reportAreaControl.remove_reportContentLoaded(handler);
    },

    ExportReport: function(format)
    {
        if (this.ExportUrlBase == null)
            return false;

        window.open(this.ExportUrlBase + encodeURIComponent(format), "_blank");
        return true;
    },

    OnPrintLoaded: function()
    {
        this.ReportViewer.Print();
    },

    Print: function()
    {
        var printInfo = this.m_printInfo;
        if (printInfo == null)
            return false;

        var printObjectId = this.ReportViewerId + "_PrintObj";
        var printObj = $get(printObjectId);

        if (printObj && printObj.readyState == 4 /* Complete */)
        {
            if (typeof printObj.Print == "undefined")
            {
                alert(this.UnableToLoadPrintMessage);
                return false;
            }

            printObj.MarginLeft = printInfo.MarginLeft;
            printObj.MarginTop = printInfo.MarginTop;
            printObj.MarginRight = printInfo.MarginRight;
            printObj.MarginBottom = printInfo.MarginBottom;

            printObj.PageHeight = printInfo.PageHeight;
            printObj.PageWidth = printInfo.PageWidth;

            printObj.Culture = printInfo.Culture;
            printObj.UICulture = printInfo.UICulture;

            printObj.UseSingleRequest = printInfo.UseSingleRequest;
            printObj.UseEmfPlus = true;

            printObj.Print(printInfo.PrintRequestPath, printInfo.PrintRequestQuery, printInfo.ReportDisplayName);
            return true;
        }
        return false;
    },

    PrintDialog: function()
    {
        var printInfo = this.m_printInfo;
        if (printInfo == null)
            return false;

        var printObjectId = this.ReportViewerId + "_PrintObj";

        // Load the print control if it hasn't happened already
        var printObj = $get(printObjectId);
        if (printObj == null)
        {
            printObj = document.createElement("OBJECT");
            printObj.id = printObjectId;
            printObj.onreadystatechange = this.OnPrintLoaded;
            printObj.style.display = "none";
            printObj.ReportViewer = this;
            // Codebase must be before classid in order to download the control
            printObj.codeBase = printInfo.CabUrl;
            printObj.setAttribute("VIEWASTEXT", "");

            //Element must be added before printing occurs as the event can fire before this is added to the window.
            var reportViewer = $get(this.ReportViewerId);
            reportViewer.appendChild(printObj);

            printObj.classid = "CLSID:" + printInfo.CabClsid;
            return true;
        }
        else
        {
            return this.Print();
        }
    },

    SetPromptAreaVisibility: function(makeVisible)
    {
        var parametersRow = $get(this.PromptAreaRowId);
        if (parametersRow == null)
            return;
        _$RVCommon.SetElementVisibility(parametersRow, makeVisible);
        this._promptSplitter._setCollapsed(!makeVisible);
        this.raisePropertyChanged("promptAreaCollapsed");
        this.ResizeViewerReportUsingContainingElement(true);
    },

    ArePromptsVisible: function()
    {
        return !this._promptSplitter._getCollapsed();
    },

    GetDocMapCells: function()
    {
        if (!this._docMapCells)
        {
            var fixedTable = $get(this.FixedTableId);
            this._docMapCells = {
                docMapHeadCell: this.HasSizingRow ? fixedTable.rows.item(0).cells.item(0) : null,
                splitterDocMapHeadCell: this.HasSizingRow ? fixedTable.rows.item(0).cells.item(1) : null,
                docMapCell: fixedTable.rows.item(this.HasSizingRow ? 4 : 3).cells.item(0),
                splitterDocMapCell: fixedTable.rows.item(this.HasSizingRow ? 4 : 3).cells.item(1),
                reportArea: $get(this.ReportAreaId),
                fixedTable: fixedTable,
                hasNodes: false,
                docMapTitleRow: null,
                docMapTitleCell: null,
                docMapContainerCell: null,
                docMapContainer: null,
                docMapTree: null
            }
            if (this.DocMapAreaId != null)
            {
                var docMapArea = $get(this.DocMapAreaId);
                if (docMapArea)
                {
                    var docMapTables = docMapArea.getElementsByTagName("table");
                    if (docMapTables.length > 0)
                    {
                        this._docMapCells.docMapTitleRow = docMapArea.getElementsByTagName("table")[0].rows.item(0);
                        this._docMapCells.docMapTitleCell = this._docMapCells.docMapTitleRow.cells.item(0);
                        this._docMapCells.docMapContainerCell = docMapArea.getElementsByTagName("table")[0].rows.item(1).cells.item(0);
                        this._docMapCells.docMapContainer = this._docMapCells.docMapContainerCell.getElementsByTagName("div")[0];
                        this._docMapCells.docMapTree = this._docMapCells.docMapContainer.getElementsByTagName("div")[0];
                        this._docMapCells.hasNodes = true;
                    }
                }
            }
        }
        return this._docMapCells;
    },

    //Changes the visibility of the DocMap to 'makeVisible'
    //Call this when you want to 'expand/collapse' the DocMap area
    SetDocMapAreaVisibility: function(makeVisible)
    {
        var docMapCells = this.GetDocMapCells();
        if (docMapCells.hasNodes)
        {
            this._docMapSplitter._setCollapsed(!makeVisible);
            this.raisePropertyChanged("documentMapCollapsed");
        }
        this._UpdateDocMapAreaUIVisibility();
    },

    //NOT INTENDED FOR PUBLIC USE.  Call SetDocMapAreaVisibility to set the DocMap Visibility
    //This updates the HTML DOM to collapse or show the DocMapArea
    //Call this when the visiblity on the DocMap has changed so the sizing can be correctly calculated.
    //'hideEverything' == true, causes the entire DocMap UI to be 'display:none' rather than 0px wide.  
    //This is necessary for resize calculations.  IE6 and 7 standards mode need to use 0px wide drawing, so the table cells
    //in the same TR are correctly calculated (extra 1px appears on the right-hand-side)
    _UpdateDocMapAreaUIVisibility: function(hideEverything)
    {
        var docMapCells = this.GetDocMapCells();

        var makeVisible = false;
        if (!hideEverything)
            makeVisible = !this._docMapSplitter._getCollapsed() && docMapCells.hasNodes;

        var isVisible = makeVisible;
        if (!hideEverything)
        {
            // Use 0px wide to show everything rather than hiding the DocMap, if there are any doc map nodes
            makeVisible = docMapCells.hasNodes;
        }

        // Document map visibility
        if (docMapCells.docMapHeadCell)
        {
            _$RVCommon.SetElementVisibility(docMapCells.docMapHeadCell, makeVisible);
        }
        _$RVCommon.SetElementVisibility(docMapCells.docMapCell, makeVisible);

        // Splitter visibility
        if (this._docMapSplitter._getCollapsable() || makeVisible)
        {
            if (docMapCells.splitterDocMapHeadCell)
                _$RVCommon.SetElementVisibility(docMapCells.splitterDocMapHeadCell, docMapCells.hasNodes);
            _$RVCommon.SetElementVisibility(docMapCells.splitterDocMapCell, docMapCells.hasNodes);
        }

        if (!hideEverything)
        {
            var size = 0;
            if (isVisible)
            {
                //If the DocMap is visible, use the splitter size to set sizing.
                size = this._docMapSplitter._getSize();
                if (isNaN(size))
                {
                    //If not calculated, ask the UI for the current size available (won't be from a previous call)
                    size = docMapCells.docMapCell.style.width;
                }
            }
            this._UpdateDocMapAreaUIWidth(size);
        }
    },

    AreDocMapAreaVisible: function()
    {
        return !this._docMapSplitter._getCollapsed();
    },

    OnPromptSplitterCollapsing: function(sender, args)
    {
        this.SetPromptAreaVisibility(!args.get_collapse())
    },

    OnDocMapSplitterCollapsing: function(sender, args)
    {
        this.SetDocMapAreaVisibility(!args.get_collapse());
    },

    //NOT INTENDED FOR PUBLIC USE.  Call SetDocMapAreaWidth to set or resize the DocMap Width
    //This validates the 'size' is an allowable DocMapArea Width
    //Call this to verify the DocMap Width can be 'size' 
    _ValidateDocMapAreaWidth: function(size)
    {
        // If no sizing row, viewer is set to SizeToReportContent.  Shouldn't need to dynamically adjust
        // any sub areas of the viewer.
        if (!this.HasSizingRow)
            return false;

        var docMapCells = this.GetDocMapCells();
        if (docMapCells.hasNodes)
        {
            if (size >= 0)
            {
                if (docMapCells.reportArea)
                {
                    var allowedWidth = docMapCells.fixedTable.clientWidth;
                    allowedWidth -= this._docMapSplitter.get_element().parentNode.clientWidth;
                    allowedWidth -= (docMapCells.reportArea.offsetWidth - docMapCells.reportArea.clientWidth);
                    if (size > allowedWidth)
                    // cannot resize
                        return false;
                }
            }
            return true;
        }
        return false;
    },

    //Set the DocMapArea to be 'size' wide.
    //The UI will be resized to fit.
    //Call this when you need to programmatically change the DocMap Width (e.g. resizing)
    SetDocMapAreaWidth: function(size)
    {
        if (this._ValidateDocMapAreaWidth(size))
        {
            if (size >= 0)
            {
                this._docMapSplitter._setSize(size);
            }
            this._UpdateDocMapAreaUIWidth(size);
        }
    },

    //NOT INTENDED FOR PUBLIC USE.  Call SetDocMapAreaWidth to set the DocMap Width
    //This updates the HTML DOM to display the desired DocMapArea Width
    //Call this when sizings change and the DocMap needs to calculate it's width
    _UpdateDocMapAreaUIWidth: function(size)
    {
        // If no sizing row, viewer is set to SizeToReportContent.  Shouldn't need to dynamically adjust
        // any sub areas of the viewer.
        if (!this._ValidateDocMapAreaWidth(size))
            return;

        var docMapCells = this.GetDocMapCells();
        if (docMapCells.hasNodes)
        {
            var sizeStr = size + "px";
            if (isNaN(size))
                sizeStr = size;

            if (size || size == 0) //If size is not null or equals zero, calculate this.  Number.NaN fails this.
            {
                if (docMapCells.docMapHeadCell)
                {
                    docMapCells.docMapHeadCell.style.width = sizeStr;
                }
                else
                {
                    docMapCells.docMapCell.style.width = sizeStr;
                }
            }

            // Set the cell width which contains the treeview even if size is NaN.
            // Size NaN happens when there is no previous resizing (or postaback cached) by the splitter. 
            // In this case the size is determined by the server rendering.  If not set, doc map content
            // can extend beyond the splitter in some browsers.
            docMapCells.docMapContainerCell.style.width = docMapCells.docMapCell.clientWidth + "px";
            docMapCells.docMapContainer.style.width = docMapCells.docMapCell.clientWidth + "px";
            $get(this.DocMapHeaderOverflowDivId).style.width = docMapCells.docMapCell.clientWidth + "px";
        }
    },

    SetDocMapAreaHeight: function(reportAreaHeight)
    {
        if (this.DocMapAreaId != null)
        {
            var docMapCells = this.GetDocMapCells();

            // Navigate down the DOM to find the document map header and document map content. 
            // Then set the height accordingly.
            if (docMapCells.docMapContainerCell != null)
            {
                var docMapContentTd = docMapCells.docMapContainerCell;
                var docMapTitleHeight = docMapCells.docMapTitleCell.scrollHeight;

                if ((reportAreaHeight - docMapTitleHeight) > 0)
                {
                    var sizingElement = docMapContentTd.firstChild;

                    if (docMapContentTd.getAttribute("HEIGHT") && !_$RVCommon.isQuirksMode())
                    {
                        //Remove the HEIGHT attribute from the TD and parent TR -- Necessary for standards mode (Safari)
                        docMapContentTd.removeAttribute("HEIGHT");
                        //TR
                        docMapContentTd.parentNode.removeAttribute("HEIGHT");
                    }

                    sizingElement.style.height = (reportAreaHeight - docMapTitleHeight) + "px";
                }
            }
        }
    },

    OnDocMapSplitterResizing: function(sender, args)
    {
        var docMapCells = this.GetDocMapCells();
        if (docMapCells.hasNodes)
        {
            this.SetDocMapAreaWidth(docMapCells.docMapCell.clientWidth + args.get_delta());
        }
    },

    Find: function(textToFind)
    {
        if (typeof textToFind != "string" || textToFind.length == 0)
            return;

        this.InvokeInteractivityPostBack("Find", textToFind);
    },

    // Returns true if the action was entirely handled on the client, false if a postback was required.
    FindNext: function()
    {
        var reportObject = this.GetReportAreaObject();

        // Everything gets hooked up by the load event.  But be safe in case someone
        // calls this too early.
        if (reportObject == null)
            return true;

        // Try to handle the search on the client (next hit is on current page)
        if (reportObject.HighlightNextSearchHit())
            return true;

        // Need to post back to get the page with the next hit
        this.InvokeInteractivityPostBack("FindNext", null);
        return false;
    },

    get_zoomLevel: function()
    {
        var reportObject = this.GetReportAreaObject();
        if (reportObject == null)
            return 100;
        return reportObject.get_zoomLevel();
    },

    set_zoomLevel: function(zoomValue)
    {
        var reportObject = this.GetReportAreaObject();
        if (reportObject == null)
            return;
        reportObject.set_zoomLevel(zoomValue);
    },

    RefreshReport: function()
    {
        this.InvokeInteractivityPostBack("Refresh", null);
    },

    get_reportAreaContentType: function()
    {
        var reportAreaObject = this.GetReportAreaObject();
        if (reportAreaObject == null)
            return Microsoft.Reporting.WebFormsClient.ReportAreaContent.None;
        return reportAreaObject.get_contentType();
    },

    OnUserCanceled: function(value)
    {
        var reportArea = $find(this.ReportAreaId);
        reportArea._OnUserCanceled();

        this.EnableDisableInput(true);
    },

    GetDirection: function()
    {
        // Cache the current direction so the server can keep track
        var directionField = $get(this.DirectionCacheId);

        var viewer = $get(this.ReportViewerId);
        directionField.value = Microsoft.Reporting.WebFormsClient._InternalReportViewer.GetRTLDirection(viewer);
        return directionField.value;
    },

    GetToolBarUpdate: function()
    {
        return this.m_toolBarUpdate;
    },

    GetReportAreaObject: function()
    {
        var reportElement = $get(this.ReportAreaId);
        if (reportElement != null)
            return reportElement.control;
        else
            return null;
    },

    GetPageRequestManager: function()
    {
        if (Sys.WebForms)
            return Sys.WebForms.PageRequestManager.getInstance();
        else
            return null;
    },

    InvokeInteractivityPostBack: function(actionType, actionParam)
    {
        $get(this.ActionTypeId).value = actionType;
        $get(this.ActionParamId).value = actionParam;
        this.PostBackToClientScript();
    },

    UpdateBrowserMode: function()
    {
        var browserModeId = this.BrowserModeId;
        if (browserModeId)
        {
            var browserModeField = $get(browserModeId);
            browserModeField.value = _$RVCommon.isQuirksMode() ? "quirks" : "standards";
        }
    }
}

Microsoft.Reporting.WebFormsClient._InternalReportViewer.registerClass("Microsoft.Reporting.WebFormsClient._InternalReportViewer", Sys.UI.Control);

Microsoft.Reporting.WebFormsClient._InternalReportViewer.GetRTLDirection = function(element)
{
    // Retrieve the cascaded direction attribute/style.
    // The currentStyle property is supported by IE.
    // Other browsers (Firefox, Safari) must use the
    // getComputedStyle method.
    if (element.currentStyle != null)
        return element.currentStyle.direction;
    else if (window.getComputedStyle != null)
    {
        var cs = window.getComputedStyle(element, null);
        return cs.getPropertyValue('direction');
    }
    return 'ltr';
}
Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

// BaseParameterInputControl /////////////////////////////////////////////////////////////////////////
Microsoft.Reporting.WebFormsClient._BaseParameterInputControl = function(element)
{
    Microsoft.Reporting.WebFormsClient._BaseParameterInputControl.initializeBase(this, [element]);
    
    this.NullCheckBoxId = null;
    this.NullValueText = null;
    this.ValidationMessage = null;
    this.PostBackOnChange = false;
    this.TriggerPostBackScript = null;
    this.TextBoxEnabledClass = null;
    this.TextBoxDisabledClass = null;
    this.TextBoxDisabledColor = null;
    
    this.m_validatorIds = new Array(0);
    this.m_customInputControlIds = new Array(0);
}

Microsoft.Reporting.WebFormsClient._BaseParameterInputControl.prototype = 
{
    initialize : function()
    {
        Microsoft.Reporting.WebFormsClient._BaseParameterInputControl.callBaseMethod(this, "initialize");

        if (this.NullCheckBoxId != null)
        {
            $addHandlers($get(this.NullCheckBoxId),
                { "click" : this.OnNullCheckClick },
                this);
        }
    },
    
    dispose : function()
    {
        if (this.NullCheckBoxId != null)
            $clearHandlers($get(this.NullCheckBoxId));
        $clearHandlers(this.get_element());

        Microsoft.Reporting.WebFormsClient._BaseParameterInputControl.callBaseMethod(this, "dispose");
    },
    
    // Custom accessor for complex object type (array)
    set_CustomInputControlIdList : function(value) { this.m_customInputControlIds = value; },
    get_CustomInputControlIdList : function()      { return this.m_customInputControlIds; },
    set_ValidatorIdList          : function(value) { this.m_validatorIds = value; },
    get_ValidatorIdList          : function()      { return this.m_validatorIds; },

    // "Abstract" methods
    GetCurrentValue : function() { return null; },
    
    GetDisplayValue : function()
    {
        var currentValue = this.GetCurrentValue();
        if (currentValue == null)
            return "";
        else
            return currentValue;
    },
    
    SetEnableState : function(enable)
    {
        var enableNonNullControls = enable;

        if (this.NullCheckBoxId != null)
        {
            this.SetInputControlEnableState(this.NullCheckBoxId, enable);
            
            var nullCheckBox = $get(this.NullCheckBoxId);
            
            // If enabling, non-null controls are enabled only if null
            // checkbox is unchecked.  If disabling, non-null controls
            // should be disabled regardless of the null checkbox state.
            enableNonNullControls = enable && !nullCheckBox.checked;
        }
        
        // Update associated validators
        for (var i = 0; i < this.m_validatorIds.length; i++)
        {
            this.SetValidatorEnableState(this.m_validatorIds[i], enableNonNullControls);
        }
        
        // Update input controls other than the null check box
        for (var i = 0; i < this.m_customInputControlIds.length; i++)
        {
            this.SetInputControlEnableState(this.m_customInputControlIds[i], enableNonNullControls)
        }
    },
    
    ValidateHasValue : function()
    {
        if (this.GetCurrentValue() == null)
        {
            alert(this.ValidationMessage);
            return false;
        }
        else
            return true;
    },

    IsNullChecked : function()
    {
        if (this.NullCheckBoxId != null)
            return $get(this.NullCheckBoxId).checked;
        else
            return false;
    },
    
    OnNullCheckClick : function(e)
    {
        if (this.PostBackOnChange && this.GetCurrentValue() != null)
            this.TriggerPostBackScript();
            
        this.SetEnableState(true);
    },
    
    SetValidatorEnableState : function(validatorId, enable)
    {
        var validator = $get(validatorId);
        if (validator != null)
        {
            validator.enabled = enable;

            // Hide disabled validators
            if (!validator.enabled)
                ValidatorValidate(validator);
        }
    },
    
    SetInputControlEnableState : function(controlId, enable)
    {
        var control = $get(controlId);

        // ASP sets the disabled tag on a span that contains the radio button
        if (control.type == "radio" || control.type == "checkbox")
            control.parentNode.disabled = !enable;
        else if (control.type == "text")
        {
            if (!enable)
            {
                control.className = this.TextBoxDisabledClass;
                control.style.backgroundColor = this.TextBoxDisabledColor;
            }
            else
            {
                control.className = this.TextBoxEnabledClass;
                control.style.backgroundColor = "";
            }
        }

        control.disabled = !enable;
    }
}

Microsoft.Reporting.WebFormsClient._BaseParameterInputControl.registerClass("Microsoft.Reporting.WebFormsClient._BaseParameterInputControl", Sys.UI.Control);
//////////////////////////////////////////////////////////////////////////////////////////////////////


// TextParameterInputControl /////////////////////////////////////////////////////////////////////////
Microsoft.Reporting.WebFormsClient._TextParameterInputControl = function(element)
{
    Microsoft.Reporting.WebFormsClient._TextParameterInputControl.initializeBase(this, [element]);
    
    this.TextBoxId = null;
    this.AllowBlank = false;
}

Microsoft.Reporting.WebFormsClient._TextParameterInputControl.prototype = 
{
    initialize : function()
    {
        Microsoft.Reporting.WebFormsClient._TextParameterInputControl.callBaseMethod(this, "initialize");
    },
    
    dispose : function()
    {
        $clearHandlers(this.get_element());
        
        Microsoft.Reporting.WebFormsClient._TextParameterInputControl.callBaseMethod(this, "dispose");
    },
    
    GetCurrentValue : function()
    {
        if (this.IsNullChecked())
            return this.NullValueText;
        else
        {
            var txtInput = $get(this.TextBoxId);
            
            if (txtInput.value == "" && !this.AllowBlank)
                return null;
            else
                return txtInput.value;
        }
    }
}

Microsoft.Reporting.WebFormsClient._TextParameterInputControl.registerClass("Microsoft.Reporting.WebFormsClient._TextParameterInputControl", Microsoft.Reporting.WebFormsClient._BaseParameterInputControl);
//////////////////////////////////////////////////////////////////////////////////////////////////////


// BoolParameterInputControl /////////////////////////////////////////////////////////////////////////
Microsoft.Reporting.WebFormsClient._BoolParameterInputControl = function(element)
{
    Microsoft.Reporting.WebFormsClient._BoolParameterInputControl.initializeBase(this, [element]);

    this.TrueCheckId = null;
    this.FalseCheckId = null;

    this.TrueValueText = null;
    this.FalseValueText = null;
}

Microsoft.Reporting.WebFormsClient._BoolParameterInputControl.prototype = 
{
    initialize : function()
    {
        Microsoft.Reporting.WebFormsClient._BoolParameterInputControl.callBaseMethod(this, "initialize");
        
        // Call the boolean disabled script to ensure the client is in the correct state for non IE browsers
        if (this.NullCheckBoxId != null)
        {
            var isNullChecked = this.IsNullChecked();
            this.SetInputControlEnableState(this.TrueCheckId, !isNullChecked);
            this.SetInputControlEnableState(this.FalseCheckId, !isNullChecked);
        }
    },
    
    dispose : function()
    {
        $clearHandlers(this.get_element());
        
        Microsoft.Reporting.WebFormsClient._BoolParameterInputControl.callBaseMethod(this, "dispose");
    },
    
    GetCurrentValue : function()
    {
        if (this.IsNullChecked())
            return this.NullValueText;
        else
        {
            var chkTrue = $get(this.TrueCheckId);
            var chkFalse = $get(this.FalseCheckId);

            if (chkTrue.checked)
                return this.TrueValueText;
            else if (chkFalse.checked)
                return this.FalseValueText;
            else
                return null;
        }
    }
}

Microsoft.Reporting.WebFormsClient._BoolParameterInputControl.registerClass("Microsoft.Reporting.WebFormsClient._BoolParameterInputControl", Microsoft.Reporting.WebFormsClient._BaseParameterInputControl);
//////////////////////////////////////////////////////////////////////////////////////////////////////


// ValidValueParameterInputControl ///////////////////////////////////////////////////////////////////
Microsoft.Reporting.WebFormsClient._ValidValueParameterInputControl = function(element)
{
    Microsoft.Reporting.WebFormsClient._ValidValueParameterInputControl.initializeBase(this, [element]);
    
    this.DropDownId = null;
    this.DropDownValidatorId = null;
    this.m_hasSelectAValue = true;
}

Microsoft.Reporting.WebFormsClient._ValidValueParameterInputControl.prototype = 
{
    initialize : function()
    {
        Microsoft.Reporting.WebFormsClient._ValidValueParameterInputControl.callBaseMethod(this, "initialize");
        
        this.RemoveSelectAValueIfNotSelected();
        
        $addHandlers($get(this.DropDownId),
            { "change" : this.RemoveSelectAValueIfNotSelected },
            this);
    },
    
    dispose : function()
    {
        $clearHandlers($get(this.DropDownId));
        
        Microsoft.Reporting.WebFormsClient._ValidValueParameterInputControl.callBaseMethod(this, "dispose");
    },

    GetCurrentValue : function()
    {
        var dropDown = $get(this.DropDownId);

        if (dropDown.selectedIndex > 0 || !this.m_hasSelectAValue)
            return dropDown.options[dropDown.selectedIndex].text;
        else
            return null;
    },
    
    RemoveSelectAValueIfNotSelected : function()
    {   
        if (this.m_hasSelectAValue)
        {
            var dropDown = $get(this.DropDownId);
            
            // If something other than "select a value" is selected
            if (dropDown.selectedIndex > 0)
            {
                // dropDown.offsetWidth can be zero if dropDown is hidden.
                if (dropDown.offsetWidth > 0)
                {
                    // If the "select a value" option is the longest one in the drop down,
                    // removing it will shrink the size of the dropdown.  This looks strange,
                    // so maintain the dropdown width.
                    dropDown.style.width = dropDown.offsetWidth + "px";
                }
                
                dropDown.remove(0);
                this.m_hasSelectAValue = false;
                
                // Now that the "select a value" option is removed,
                // the drop down validator is no longer necessary.
                // We cannot just disable the validator, since it
                // could be re-enabled by some client action.  Instead,
                // we just set the client validation function to null so
                // no actual validation occurs.
                if (this.DropDownValidatorId != null)
                {
                    var validator = $get(this.DropDownValidatorId);
                    if (validator != null)
                        validator.clientvalidationfunction = null;
                }
            }
        }
    }
}

Microsoft.Reporting.WebFormsClient._ValidValueParameterInputControl.registerClass("Microsoft.Reporting.WebFormsClient._ValidValueParameterInputControl", Microsoft.Reporting.WebFormsClient._BaseParameterInputControl);
//////////////////////////////////////////////////////////////////////////////////////////////////////

// GenericDropDownParameterInputControl //////////////////////////////////////////////////////////////
Microsoft.Reporting.WebFormsClient._GenericDropDownParameterInputControl = function(element)
{
    Microsoft.Reporting.WebFormsClient._GenericDropDownParameterInputControl.initializeBase(this, [element]);
    
    this.EnabledImageSrc = null;
    this.DisabledImageSrc = null;
    this.ImageId = null;
    this.TextBoxId = null;
    this.FloatingIframeId = null;
    this.RelativeDivId = null;
}

Microsoft.Reporting.WebFormsClient._GenericDropDownParameterInputControl.prototype = 
{
    initialize : function()
    {
        Microsoft.Reporting.WebFormsClient._GenericDropDownParameterInputControl.callBaseMethod(this, "initialize");

        $addHandlers($get(this.ImageId),
            { "click" : this.OnDropDownImageClick },
            this);
    },
    
    dispose : function()
    {
        $clearHandlers($get(this.ImageId));
        $clearHandlers(this.get_element());
        
        Microsoft.Reporting.WebFormsClient._GenericDropDownParameterInputControl.callBaseMethod(this, "dispose");
    },
    
    OnDropDownImageClick : function(e)
    {
        this.ToggleFloatingFrameVisibility();
        e.stopPropagation();
        e.preventDefault();
    },
    
    SetEnableState : function(enable)
    {
        Microsoft.Reporting.WebFormsClient._GenericDropDownParameterInputControl.callBaseMethod(this, "SetEnableState", [enable]);

        var inputCtrl = $get(this.ImageId);
        this.SelectImage(!inputCtrl.disabled);
    },
    
    SelectImage : function(useEnabledImage)
    {
        var inputCtrl = $get(this.ImageId);
        if (useEnabledImage)
        {
            inputCtrl.src = this.EnabledImageSrc;
            inputCtrl.style.cursor = 'pointer';
        }
        else
        {
            inputCtrl.src = this.DisabledImageSrc;
            inputCtrl.style.cursor = 'default';
        }    
    },
    
    ToggleFloatingFrameVisibility : function()
    {
        var floatingIframe = $get(this.FloatingIframeId);
        if (floatingIframe.style.display == "none")
            this.ShowFloatingFrame();
        else
            this.HideFloatingFrame();
    },
    
    ShowFloatingFrame : function()
    {
        var floatingIFrame = $get(this.FloatingIframeId);

        // Position the drop down. This must be done before making the frame visible. Otherwise, 
        // a scroll bar is likely to appear as a result of showing the frame which would make the 
        // position invalid.
        if (this.RelativeDivId == null)
        {
            var newDropDownPosition = this.GetDropDownPosition();
            floatingIFrame.style.left = newDropDownPosition.Left + "px";
            floatingIFrame.style.top = newDropDownPosition.Top + "px";
        }

        // only show if the frame is not currently visible.
        if (floatingIFrame.style.display != "inline")
        {
            var visibleTextBox = $get(this.TextBoxId);

            floatingIFrame.style.width = visibleTextBox.offsetWidth + "px";
            floatingIFrame.style.display = "inline";
        }

        if (this.RelativeDivId != null)
        {
            // set the zIndex of the containing div so the frame doesn't get overlapped
            // by other elements outside the containing div.
            var relativeDiv = $get(this.RelativeDivId);
            relativeDiv.style.zIndex = 1;
        }
        else
        {
            // poll for changes in screen position
            this.PollForDropDownMovement();
        }
        
        // Define an OnShowEvent event for consumers of this class.
        var handler = this.get_events().getHandler("OnShowEvent");
        if (handler != null)
            handler(this, Sys.EventArgs.Empty);
    },
    
    HideFloatingFrame : function()
    {
        var floatingIFrame = $get(this.FloatingIframeId);

        if (this.RelativeDivId != null)
        {
            // reset the zIndex
            var relativeDiv = $get(this.RelativeDivId);
            relativeDiv.style.zIndex = 0;
        }
        
        floatingIFrame.style.display = "none";

        var handler = this.get_events().getHandler("OnHideEvent");
        if (handler != null)
            handler(this, Sys.EventArgs.Empty);

        // When the dropdown collapses, the parameter is done changing value,
        // so perform the autopost back for dependent parameters.
        if (this.PostBackOnChange)
            this.TriggerPostBackScript();
    },
    
    GetDropDownPosition : function()
    {
        var visibleTextBox = $get(this.TextBoxId);
        var floatingIFrame = $get(this.FloatingIframeId);

        // NOTE: In mozilla, x.offsetParent can only be accessed if x is visible.
        var originalDisplay = floatingIFrame.style.display;
        floatingIFrame.style.display = "inline";
        var offsetParent = floatingIFrame.offsetParent;
        floatingIFrame.style.display = originalDisplay;

        var textBoxPosition = this.GetObjectPosition(visibleTextBox, offsetParent);

        return {Left:textBoxPosition.Left, Top:textBoxPosition.Top + visibleTextBox.offsetHeight};
    },

    GetObjectPosition : function(obj, relativeToObj)
    {
        var totalTop = 0;
        var totalLeft = 0;
        
        var parent = obj.offsetParent;
        if (parent != null) 
        {
            // this loop goes through each step along the offsetParent hierarchy except the last step.
            // in the last step we do not want to make the scrollTop/scrollLeft correction.
            while (parent != relativeToObj && parent != null)
            {
                // topToTop is the distance from the top of obj to the top of parent.
                var topToTop = obj.offsetTop - parent.scrollTop;
                totalTop += topToTop;

                // leftToLeft is the distance from the outer left edge of obj to the outer left edge of parent
                var leftToLeft = obj.offsetLeft - parent.scrollLeft;
                totalLeft += leftToLeft;

                obj = parent;
                parent = parent.offsetParent;
            }
        }
        
        // The last step is to add in the distance from the top of obj to parent (the object 
        // that we are measuring relative to).
        // Therefore the scroll top/left correction is not needed.
        totalTop += obj.offsetTop;
        totalLeft += obj.offsetLeft;

        // if the parent != relativeToObj, then it must be null (per the exit conditions of the while
        // loop). Then the relativeToObject must be the top of the offset hierarchy, which means
        // either it is null or its parent is null. If neither of these are true, then we have an 
        // error and obj is not contained within relativeToObj.
        if (parent != relativeToObj && relativeToObj != null && relativeToObj.offsetParent != null)
        {
            // invalid input, obj is not contained within relativeToObj
            return {Left:0, Top:0};
        }

        if (parent != relativeToObj && relativeToObj != null)
        {
            totalTop -= relativeToObj.offsetTop;
            totalLeft -= relativeToObj.offsetLeft;
        }

        return {Left:totalLeft, Top:totalTop};
    },
    
    PollForDropDownMovement : function()
    {
        var element = "$get('" + escape(this.get_element().id) + "')";
        setTimeout("if (" + element + " != null)" + element + ".control.PollingCallback();", 100);
    },

    PollingCallback : function()
    {
        // If the iframe isn't visible, no more events.
        var floatingIframe = $get(this.FloatingIframeId);
        if (floatingIframe.style.display != "inline")
            return;

        // If the text box moved, something on the page resized, so close the editor
        var expectedIframePos = this.GetDropDownPosition();
        if (floatingIframe.style.left != expectedIframePos.Left + "px" ||
            floatingIframe.style.top != expectedIframePos.Top + "px")
            this.HideFloatingFrame();
        else
            this.PollForDropDownMovement();
    }
}

Microsoft.Reporting.WebFormsClient._GenericDropDownParameterInputControl.registerClass("Microsoft.Reporting.WebFormsClient._GenericDropDownParameterInputControl", Microsoft.Reporting.WebFormsClient._BaseParameterInputControl);
//////////////////////////////////////////////////////////////////////////////////////////////////////


// CalendarDropDownParameterInputControl /////////////////////////////////////////////////////////////
Microsoft.Reporting.WebFormsClient._CalendarDropDownParameterInputControl = function(element)
{
    Microsoft.Reporting.WebFormsClient._CalendarDropDownParameterInputControl.initializeBase(this, [element]);
    
    this.BaseCalendarUrl = null;
}

Microsoft.Reporting.WebFormsClient._CalendarDropDownParameterInputControl.prototype = 
{
    initialize : function()
    {
        Microsoft.Reporting.WebFormsClient._CalendarDropDownParameterInputControl.callBaseMethod(this, "initialize");
    },
    
    dispose : function()
    {
        $clearHandlers(this.get_element());
        
        Microsoft.Reporting.WebFormsClient._CalendarDropDownParameterInputControl.callBaseMethod(this, "dispose");
    },
    
    GetCurrentValue : function()
    {
        if (this.IsNullChecked())
            return this.NullValueText;
        else
        {
            var txtInput = $get(this.TextBoxId);
            if (txtInput.value == "")
                return null;
            else
                return txtInput.value;
        }
    },
    
    OnDropDownImageClick : function(e)
    {
        Microsoft.Reporting.WebFormsClient._CalendarDropDownParameterInputControl.callBaseMethod(this, "OnDropDownImageClick", [e]);

        var calendarUrl = this.BaseCalendarUrl + encodeURIComponent($get(this.TextBoxId).value);
        this.SetCalendarUrl(calendarUrl, false);
    },
    
    OnCalendarSelection : function(resultfield)
    {
        // When the calendar is collapsing as a result of having a date selected, the calendar itself
        // has the focus.  Move the focus to the calendar button.  Otherwise IE can get into a state
        // where it won't allow anything to have the focus.
        var inputCtrl = $get(this.ImageId);
        inputCtrl.focus();
        
        this.ToggleFloatingFrameVisibility();

        this.SetCalendarUrl(this.BaseCalendarUrl + encodeURIComponent(resultfield.value), true);
    },
    
    SetCalendarUrl : function(url, forceReload)
    {
        var iframeObject = $get(this.FloatingIframeId).contentWindow;
        
        if (!forceReload) 
        {
            // If the selected dates are the different then get a new page
            var currentDate = this.GetSelectedDateFromUrl(iframeObject.document.location.search).toUpperCase();
            var newDate = this.GetSelectedDateFromUrl(url).toUpperCase();
            if (currentDate == newDate)
            {
                if (iframeObject.document.readyState == "complete")
                {
                    // Hide the calendar that is showing and make sure the one with the 
                    // users selection is showing.
                    iframeObject.HideUnhide(iframeObject.g_currentShowing, "DatePickerDiv", iframeObject.g_currentID, null);
                    return;
                }
            }
        }

        if (iframeObject.document.readyState == "complete")
        {
            // Show the loading page if navigating to a new calendar
            iframeObject.Hide(iframeObject.g_currentShowing);
            iframeObject.Unhide("LoadingDiv");
        }
        
        iframeObject.document.location.replace(url);
    },
    
    GetSelectedDateFromUrl : function(url)
    {
        var pos = url.lastIndexOf("selectDate");
        var date = null;
        
        if (pos != -1)
        {
            date = url.substring(pos);
            pos = date.indexOf("=");
            
            if (pos == -1)
                date = null;
            else
            {
                date = date.substring(pos + 1);
                
                pos = date.indexOf("&");
                if (pos != -1)
                    date = date.substring(0, pos);
            }
        }
        
        return date;
    }
}

Microsoft.Reporting.WebFormsClient._CalendarDropDownParameterInputControl.registerClass("Microsoft.Reporting.WebFormsClient._CalendarDropDownParameterInputControl", Microsoft.Reporting.WebFormsClient._GenericDropDownParameterInputControl);
//////////////////////////////////////////////////////////////////////////////////////////////////////

// MultiValueParameterInputControl ///////////////////////////////////////////////////////////////////
Microsoft.Reporting.WebFormsClient._MultiValueParameterInputControl = function(element)
{
    Microsoft.Reporting.WebFormsClient._MultiValueParameterInputControl.initializeBase(this, [element]);
    
    this.HasValidValueList = false;
    this.AllowBlank = false;
    this.FloatingEditorId = null;
    this.TextAreaDelimiter = null;
    this.ListSeparator = null;
    this.GripImage = null;
    this.GripImageRTL = null;
}

Microsoft.Reporting.WebFormsClient._MultiValueParameterInputControl.prototype = 
{
    initialize : function() 
    {
        Microsoft.Reporting.WebFormsClient._MultiValueParameterInputControl.callBaseMethod(this, "initialize");

        $addHandlers($get(this.TextBoxId),
            { "click": this.OnTextBoxClick },
            this);
        this.UpdateTextBoxWithDisplayValue();
    },

    dispose : function() 
    {
        $clearHandlers(this.get_element());
        $clearHandlers($get(this.TextBoxId));
        
	if (this._resizeBehavior)
        {
            this._resizeBehavior.dispose();
            delete this._resizingDelegate;
        }
        
        Microsoft.Reporting.WebFormsClient._MultiValueParameterInputControl.callBaseMethod(this, "dispose");
    },

    OnTextBoxClick : function(e) 
    {
        this.ShowFloatingFrame();
        e.stopPropagation();
    },

    GetCurrentValue : function() 
    {
        if (this.HasValidValueList)
            return this.GetCurrentValueFromValidValueList();
        else
            return this.GetCurrentValueFromTextEditor();
    },

    GetCurrentValueFromTextEditor : function() 
    {
        var span = $get(this.FloatingEditorId);
        var editor = span.getElementsByTagName("TEXTAREA")[0];

        var valueString = editor.value;

        // Remove the blanks
        if (!this.AllowBlank) 
        {
            // Break down the text box string to the individual lines
            var valueArray = valueString.split(this.TextAreaDelimiter);

            var finalValue = "";
            for (var i = 0; i < valueArray.length; i++)
            {
                // If the string is non-blank, add it
                if (valueArray[i].length > 0) 
                {
                    if (finalValue.length > 0)
                        finalValue += this.ListSeparator;
                    finalValue += valueArray[i];
                }
            }

            if (finalValue.length == 0)
                return null;
            else
                return finalValue;
        }
        else
            return valueString.replace(new RegExp(this.TextAreaDelimiter, "g"), this.ListSeparator);
    },

    GetCurrentValueFromValidValueList : function() 
    {
        var valueString = "";

        // Get the table
        var div = $get(this.FloatingEditorId);
        var table = div.getElementsByTagName("TABLE")[0];

        // If there is only one element, it is a real value, not the select all option
        var startIndex = 0;
        if (table.rows.length > 1)
            startIndex = 1;

        for (var i = startIndex; i < table.rows.length; i++) 
        {
            var rowInfo = this.GetValueForMultiValidValueRow(table, i);

            if (rowInfo.CheckBox.checked) 
            {
                if (valueString.length > 0)
                    valueString += this.ListSeparator;
                valueString += this.Trim(rowInfo.Label);
            }
        }

        if (valueString.length == 0)
            return null;
        else
            return valueString;
    },

    GetValueForMultiValidValueRow : function(table, rowIndex) 
    {
        // Get the first cell of the row
        var firstCell = table.rows[rowIndex].cells[0];
        var span = firstCell.childNodes[0];

        var checkBox = span.childNodes[0];

        // Span is not always generated.
        var label;
        if (span.nodeName == "INPUT") 
        {
            checkBox = span;
            label = firstCell.childNodes[1];
        }
        else
            label = span.childNodes[1];

        // The label can be blank.  If it exists, make it non-zero length so that
        // view report button validation realizes there is a value selected.  Makes
        // text summary a little easier to read too.
        var labelStr = " ";
        if (label != null && label.firstChild != null)
            labelStr = label.firstChild.nodeValue;
        if (labelStr == "")
            labelStr = " ";

        return {CheckBox: checkBox, Label: labelStr};
    },

    // Trim leading and trailing spaces (NBSP) from a string
    Trim : function(text) 
    {
        var startpos = text.length;
        var nbsp = 160; // Remove occurrances of NBSP
        for (var i = 0; i < text.length; i++) 
        {
            // Look for &nbsp
            if (text.charCodeAt(i) != nbsp) 
            {
                startpos = i;
                break;
            }
        }
        var endpos = text.length - 1;
        for (var j = endpos; j >= startpos; j--) 
        {
            if (text.charCodeAt(j) != nbsp) 
            {
                endpos = j;
                break;
            }
        }
        endpos++;
        return text.substring(startpos, endpos);
    },

    UpdateTextBoxWithDisplayValue : function() 
    {
        var textBox = $get(this.TextBoxId);
        textBox.value = this.GetDisplayValue();
    },

    ShowFloatingFrame : function() 
    {
        var floatingEditor = $get(this.FloatingEditorId);

        if (this.RelativeDivId == null)
        {
            // Position the drop down.  This must be done before calling showing the frame. Otherwise, 
            // a scroll bar is likely to appear as a result of the frame becoming visible which would make the 
            // position invalid.
            var newEditorPosition = this.GetDropDownPosition();
            floatingEditor.style.left = newEditorPosition.Left + "px";
            floatingEditor.style.top = newEditorPosition.Top + "px";
        }

        // only show if the editor is not currently visible. 
        if (floatingEditor.style.display == "inline")
            return;
        
        // Set drop down and summary string to the same width to make it look like a drop down
        var visibleTextBox = $get(this.TextBoxId);
        floatingEditor.style.width = visibleTextBox.offsetWidth + "px";

        floatingEditor.style.display = "inline";

        // Show the iframe
        Microsoft.Reporting.WebFormsClient._MultiValueParameterInputControl.callBaseMethod(this, "ShowFloatingFrame");

        // Set the iframe height to our controls height
        var floatingIFrame = $get(this.FloatingIframeId);
        floatingIFrame.style.height = floatingEditor.offsetHeight;

        if (!(this._resizeBehavior))
            this._attachResizeHandle()
        else    
            this._resizeBehavior._reset();
    },

    _attachResizeHandle: function() 
    {
        var floatingEditor = $get(this.FloatingEditorId);
        if (this.HasValidValueList)
        {
            if (floatingEditor.offsetWidth > floatingEditor.scrollWidth &&
                floatingEditor.offsetHeight > floatingEditor.scrollHeight)
            {
                // no need of resizable behavior;
                return;
            }
        }

        // If we have horizontal overflow, horizontal scrollbar appears.
        // Increase the minimum height, if is less that 200px, so the last row to be visible.
        // This compensation have to be done only for IE < 8
        var scrollCompensation = 0;
        if (Sys.Browser.agent == Sys.Browser.InternetExplorer && Sys.Browser.documentMode < 8)
        {
            scrollCompensation = Math.max(0, (floatingEditor.offsetHeight - floatingEditor.clientHeight));
        }
        var minimumHeight = Math.min(150, floatingEditor.offsetHeight + scrollCompensation);
        var minimumWidth = parseInt(floatingEditor.style.width) - parseInt(floatingEditor.style.borderWidth) * 2;
        
        // the textarea must have overflow set in the server code.
        var resizeOverfow = this.HasValidValueList ? "auto" : "hidden";

        if (!this.HasValidValueList)
        {
            this._textArea = floatingEditor.getElementsByTagName("textarea")[0];
            // Firefox includes the scrollbars in the padding for text areas, despite outer box model. 
            if (Sys.Browser.agent == Sys.Browser.Firefox)
            {
                this._textArea.style.padding = "0px";
            }
        }
        this._resizeBehavior = $create(Microsoft.Reporting.WebFormsClient.ResizableControlBehavior,
                {
                    GripImage: this.GripImage,
                    GripImageRTL: this.GripImageRTL,
                    MinimumHeight: minimumHeight,
                    MinimumWidth: minimumWidth,
                    Overflow: resizeOverfow,
                    id: this.FloatingEditorId + "_resize"
                }, null, null, floatingEditor
        );
        this._resizingDelegate = Function.createDelegate(this, this._onResizing)
        this._resizeBehavior.add_resizing(this._resizingDelegate);
    },

    _onResizing: function(sender, args)
    {
        var floatingEditor = $get(this.FloatingEditorId);
        var floatingIFrame = $get(this.FloatingIframeId);
        var size = sender.get_Size();
        // check if the frame is displayed first to reduce flickering.
        if (floatingIFrame.style.display != "block")
        {
            floatingIFrame.style.display = "block";
        }

        // The size of the text area have to be set explicitly.
        if (!this.HasValidValueList && this._textArea)
        {
            if (_$RVCommon.isIEQuirksMode())
            {
                this._textArea.style.width = size.width + "px";
                this._textArea.style.height = size.height + "px";
            }
            else
            {
                // standard box mode include padding;
                var padding = (parseInt(this._textArea.style.padding) * 2);
                this._textArea.style.width = size.width - padding + "px";
                this._textArea.style.height = size.height - padding + "px";
            }
        }

        floatingIFrame.style.left = floatingEditor.style.left;
        floatingIFrame.style.width = size.width + "px";
        floatingIFrame.style.height = size.fullHeight + "px";
    },

    HideFloatingFrame : function() 
    {
        var floatingEditor = $get(this.FloatingEditorId);

        // Hide the editor
        floatingEditor.style.display = "none";

        // Update the text box
        this.UpdateTextBoxWithDisplayValue();

        // Hide the iframe
        Microsoft.Reporting.WebFormsClient._MultiValueParameterInputControl.callBaseMethod(this, "HideFloatingFrame");
    },

    OnSelectAllClick : function(src) 
    {
        // Get the table
        var div = $get(this.FloatingEditorId);
        var table = div.getElementsByTagName("TABLE")[0];

        for (var i = 1; i < table.rows.length; i++) 
        {
            var rowInfo = this.GetValueForMultiValidValueRow(table, i);

            rowInfo.CheckBox.checked = src.checked;
        }
    },

    OnValidValueClick : function(src, selectAllCheckBox) 
    {
        if (!src.checked)
            selectAllCheckBox.checked = false;
    }
}

Microsoft.Reporting.WebFormsClient._MultiValueParameterInputControl.registerClass("Microsoft.Reporting.WebFormsClient._MultiValueParameterInputControl", Microsoft.Reporting.WebFormsClient._GenericDropDownParameterInputControl);

//////////////////////////////////////////////////////////////////////////////////////////////////////
Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._PromptArea = function(element)
{
    Microsoft.Reporting.WebFormsClient._PromptArea.initializeBase(this, [element]);

    this.ReportViewerId = null;

    this.CredentialsLinkId = null;
    this.ParametersGridID = null;
    this.ViewReportButtonId = null;

    this.m_activeDropDown = null;
    this.m_parameterIdList = null;
    this.m_credentialIdList = null;
    this.m_hookedEvents = false;

    this.m_onReportViewerLoadingChangedDelegate = Function.createDelegate(this, this.OnReportViewerLoadingChanged);
}

Microsoft.Reporting.WebFormsClient._PromptArea.prototype =
{
    initialize: function()
    {
        Microsoft.Reporting.WebFormsClient._PromptArea.callBaseMethod(this, "initialize");

        var viewReportButton = $get(this.ViewReportButtonId);

        if (viewReportButton != null)
        {
            $addHandlers($get(this.ViewReportButtonId),
                { "click": this.OnViewReportClick },
                this);
        }

        var reportViewer = $find(this.ReportViewerId);
        if (reportViewer != null)
            reportViewer.add_propertyChanged(this.m_onReportViewerLoadingChangedDelegate);
    },

    dispose: function()
    {
        var viewReportButton = $get(this.ViewReportButtonId);

        if (viewReportButton != null)
            $clearHandlers(viewReportButton);

        var reportViewer = $find(this.ReportViewerId);
        if (reportViewer != null)
            reportViewer.remove_propertyChanged(this.m_onReportViewerLoadingChangedDelegate);

        $clearHandlers(this.get_element());

        delete this.m_onReportViewerLoadingChangedDelegate;
        this.m_onReportViewerLoadingChangedDelegate = null;

        Microsoft.Reporting.WebFormsClient._PromptArea.callBaseMethod(this, "dispose");
    },

    // Custom accessor for complex object type (array)
    set_ParameterIdList: function(value) { this.m_parameterIdList = value; },
    get_ParameterIdList: function() { return this.m_parameterIdList; },
    set_CredentialIdList: function(value) { this.m_credentialIdList = value; },
    get_CredentialIdList: function() { return this.m_credentialIdList; },

    ShouldValidateParameters: function()
    {
        if (this.m_parameterIdList == null)
            return false;

        // Get the credential link
        var credentialLink = $get(this.CredentialsLinkId);

        // The credential link is not rendered in 2 cases.
        // 1 - There are no credentials.  If there are no credentials but there
        //     is a prompt area at all, then it must have parameters which should
        //     then be validated.
        // 2 - The credential prompts are being shown initially because they aren't
        //     satisfied.  In this case, there are no rendered parameter prompts, so
        //     it does't hurt to validate all 0 of them.
        if (credentialLink == null)
            return true;

        // Initial view was of parameters and it still is
        return credentialLink.style.display != "none";
    },

    ShouldValidateCredentials: function()
    {
        if (this.m_credentialIdList == null)
            return false;

        // Get the credential link
        var credentialLink = $get(this.CredentialsLinkId);

        // The credential link is not rendered in 2 cases.
        // 1 - There are no credentials.  In this case, validating all 0 of them
        //     does no harm.
        // 2 - The credential prompts are being shown initially because they aren't
        //     satisfied.  In this case, we always want to validate the input boxes.
        // Therefore, if there is no credential link, validate the credentials.
        if (credentialLink == null)
            return true;

        // Switched back from intial view of parameters to credentials
        return credentialLink.style.display == "none";
    },

    ValidateInputs: function()
    {
        if (this.ShouldValidateCredentials())
        {
            for (var i = 0; i < this.m_credentialIdList.length; i++)
            {
                var credentialElement = $get(this.m_credentialIdList[i]);
                var credentialControl = credentialElement.control;
                if (!credentialControl.ValidateHasValue())
                    return false;
            }
        }

        if (this.ShouldValidateParameters())
        {
            for (var i = 0; i < this.m_parameterIdList.length; i++)
            {
                var parameterElement = $get(this.m_parameterIdList[i]);
                var parameterControl = parameterElement.control;
                if (!parameterControl.ValidateHasValue())
                    return false;
            }
        }

        return true;
    },

    OnViewReportClick: function(e)
    {
        if (!this.ValidateInputs())
            e.preventDefault();
    },

    OnChangeCredentialsClick: function()
    {
        // Hide the link
        var credentialLink = $get(this.CredentialsLinkId);
        credentialLink.style.display = "none";

        // Make sure each row in the table is visible
        var paramsTable = $get(this.ParametersGridID);
        for (var i = 0; i < paramsTable.rows.length; i++)
        {
            var row = paramsTable.rows[i];
            var makeVisible = row.attributes.getNamedItem("IsParameterRow") == null;
            _$RVCommon.SetElementVisibility(row, makeVisible);
        }
        
        // Changing which rows are visible can affect the height of the prompt area.  Need to recalc layout.
        var reportViewer = $find(this.ReportViewerId);
        reportViewer.recalculateLayout();
    },

    HookParameterEvents: function()
    {
        if (this.m_hookedEvents || this.m_parameterIdList == null)
            return;

        for (var i = 0; i < this.m_parameterIdList.length; i++)
        {
            var parameterObject = $get(this.m_parameterIdList[i]).control;
            if (Microsoft.Reporting.WebFormsClient._GenericDropDownParameterInputControl.isInstanceOfType(parameterObject))
            {
                parameterObject.get_events().addHandler("OnShowEvent", Function.createDelegate(this, this.OnNewActiveDropDown));
                parameterObject.get_events().addHandler("OnHideEvent", Function.createDelegate(this, this.OnActiveDropDownHidden));
            }
        }

        this.m_hookedEvents = true;
    },

    OnNewActiveDropDown: function(sender, eventArgs)
    {
        // Hide the previously visible dropDown
        if (this.m_activeDropDown != sender && this.m_activeDropDown != null)
            this.m_activeDropDown.HideFloatingFrame();

        this.m_activeDropDown = sender;
    },

    OnActiveDropDownHidden: function(sender, eventArgs)
    {
        // Check that it is still listed as active, in case event ordering
        // caused the show on the new one to fire first
        if (this.m_activeDropDown == sender)
            this.m_activeDropDown = null;
    },

    HideActiveDropDown: function()
    {
        if (this.m_activeDropDown != null)
            this.m_activeDropDown.HideFloatingFrame();
    },

    OnReportViewerLoadingChanged : function(sender, e)
    {
        if (e.get_propertyName() == "isLoading")
        {
            var reportViewer = $find(this.ReportViewerId);

            var isLoading = reportViewer.get_isLoading();
            
            var shouldEnable = false;
            if (!isLoading)
            {
                var reportAreaContentType = reportViewer.get_reportAreaContentType();
                shouldEnable = reportAreaContentType != Microsoft.Reporting.WebFormsClient.ReportAreaContent.WaitControl;            
            }

            this.EnableDisableInput(shouldEnable);
        }
    },

    EnableDisableInput: function(shouldEnable)
    {
        if (shouldEnable)
            this.HookParameterEvents();

        // Enable/Disable UI elements.  If enabling and about to trigger a postback
        // (which would just disable things again), skip the enable.
        if (!shouldEnable || !Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.AsyncTriggerSelected)
        {
            //Update the ViewReport Button
            if (this.ViewReportButtonId)
            {
                var button = $get(this.ViewReportButtonId);
                if (button)
                    button.disabled = !shouldEnable;
            }

            //Update all the credential controls
            if (this.m_credentialIdList)
            {
                for (var i = 0; i < this.m_credentialIdList.length; i++)
                {
                    var credentialElement = $get(this.m_credentialIdList[i]);
                    var credentialControl = credentialElement.control;
                    credentialControl.SetEnableState(shouldEnable);
                }
            }
            
            //Update all the parameter controls
            if (this.m_parameterIdList)
            {
                for (var i = 0; i < this.m_parameterIdList.length; i++)
                {
                    var parameterElement = $get(this.m_parameterIdList[i]);
                    var parameterControl = parameterElement.control;
                    parameterControl.SetEnableState(shouldEnable);
                }
            }
        }
    }
}

Microsoft.Reporting.WebFormsClient._PromptArea.registerClass("Microsoft.Reporting.WebFormsClient._PromptArea", Sys.UI.Control);



// DataSourceCredential /////////////////////////////////////////////////////
Microsoft.Reporting.WebFormsClient.DataSourceCredential = function(element)
{
    Microsoft.Reporting.WebFormsClient.DataSourceCredential.initializeBase(this, [element]);
    
    this.UserNameId = null;
    this.PasswordId = null;
    this.ValidationMessage = null;
}

Microsoft.Reporting.WebFormsClient.DataSourceCredential.prototype = 
{
    initialize : function()
    {
        Microsoft.Reporting.WebFormsClient.DataSourceCredential.callBaseMethod(this, "initialize");
    },
    
    dispose : function()
    {
        $clearHandlers(this.get_element());
        
        Microsoft.Reporting.WebFormsClient.DataSourceCredential.callBaseMethod(this, "dispose");
    },

    ValidateHasValue : function()
    {
        var userControl = $get(this.UserNameId);
        if (userControl.value == "")
        {
            alert(this.ValidationMessage);
            return false;
        }
        return true;
    },
    
    SetEnableState : function(shouldEnable)
    {
        if(this.UserNameId)
        {
            var userControl = $get(this.UserNameId);
            userControl.disabled = !shouldEnable;
        }
            
        if(this.PasswordId)
        {
            var passwordControl = $get(this.PasswordId)
            passwordControl.disabled = !shouldEnable;
        }
    }    
}

Microsoft.Reporting.WebFormsClient.DataSourceCredential.registerClass("Microsoft.Reporting.WebFormsClient.DataSourceCredential", Sys.UI.Control);
﻿Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._ReportArea = function(element)
{
    Microsoft.Reporting.WebFormsClient._ReportArea.initializeBase(this, [element]);

    // MaintainPosition
    this.m_previousViewportOffset = null; // Previous distance of the alignment object from the upper left corner of the visible area

    // AvoidScrolling
    this.m_previousScrollOffset = null;

    this.VisibleReportContentContainerId = null;
    this.ReportControlId = null;
    this.NonReportContentId = null;
    this.ScrollPositionId = null;
    this.ReportAreaVisibilityStateId = null;

    // Only used for checking when the report page changes.  Use this.GetReportPage() to access the visible element.
    this.m_currentReportPage = null;

    this.m_contentTypeToMakeVisibleOnNextLoad = Microsoft.Reporting.WebFormsClient.ReportAreaContent.None;
    this.m_isNewContentForNonReportContentArea = false;

    this.m_lastReportPageCellId = null;

    this.m_hookReportObjectLoadedDelegate = Function.createDelegate(this, this.HookReportObjectLoaded);
    this.m_onReportPageLoadedDelegate = Function.createDelegate(this, this.OnReportPageLoaded);

    this.m_userCanceled = false;
}

Microsoft.Reporting.WebFormsClient._ReportArea.prototype =
{
    initialize: function()
    {
        Microsoft.Reporting.WebFormsClient._ReportArea.callBaseMethod(this, "initialize");

        // Listen for new instances of the report object from async postbacks
        Sys.Application.add_load(this.m_hookReportObjectLoadedDelegate);

        $addHandlers(this.get_element(),
            { "scroll": this.OnScroll,
                "resize": this.OnScroll
            },
            this);
    },

    dispose: function()
    {
        if (this.VisibleReportContentContainerId)
        {
            //Remove the report from the visible container to speed up ASP.Net dispose.
            //ASP.Net walks the DOM looking for dispose calls.  Since the report is solely HTML,
            //there are no controls to dispose, so it's safe to remove.
            var visibleContainer = $get(this.VisibleReportContentContainerId);
            if (visibleContainer && visibleContainer.childNodes.length > 0)
            {
                visibleContainer.removeChild(visibleContainer.childNodes[0]);
            }
        }

        $clearHandlers(this.get_element());

        Sys.Application.remove_load(this.m_hookReportObjectLoadedDelegate);
        delete this.m_hookReportObjectLoadedDelegate;

        delete this.m_onReportPageLoadedDelegate;

        Microsoft.Reporting.WebFormsClient._ReportArea.callBaseMethod(this, "dispose");
    },

    HookReportObjectLoaded: function()
    {
        var reportPage = this.GetReportPage();
        if (reportPage != null && reportPage != this.m_currentReportPage)
        {
            // Save off the old report cell ID before removing the reference to the last report page.
            this.m_lastReportCellId = null;
            if (this.m_currentReportPage != null)
                this.m_lastReportCellId = this.m_currentReportPage.ReportCellId;

            this.m_currentReportPage = reportPage;

            // event will be disconnected by report object dispose
            reportPage.add_allContentLoaded(this.m_onReportPageLoadedDelegate);
        }
    },

    IsLoading: function()
    {
        var reportPage = this.GetReportPage();
        return reportPage == null || reportPage.IsLoading();
    },

    OnReportPageLoaded: function()
    {
        var reportPage = this.GetReportPage();

        this.SwapReport();
        this.SetRegionVisibility();

        reportPage.OnReportVisible();
        this.ScrollToTarget();

        reportPage.OnReportScrolled();

        // Always raise the area changed event
        var areaLoadedHandler = this.get_events().getHandler("contentChanged");
        if (areaLoadedHandler)
        {
            var eventArgs = new Sys.EventArgs();
            eventArgs.ToolBarUpdate = reportPage.get_ToolBarUpdate();

            areaLoadedHandler(this, eventArgs);
        }

        // Clear state that was saved for the report page swap so that
        // it doesn't affect the next page swap.
        this.m_previousViewportOffset = null;
        this.m_previousScrollOffset = null;
    },

    get_scrollPosition: function()
    {
        var scrollableArea = this.get_element();
        return new Sys.UI.Point(scrollableArea.scrollLeft, scrollableArea.scrollTop);
    },

    set_scrollPosition: function(scrollPoint)
    {
        var reportAreaElement = this.get_element();
        reportAreaElement.scrollTop = scrollPoint.y;
        reportAreaElement.scrollLeft = scrollPoint.x;

        this.raisePropertyChanged("scrollPosition");
    },

    // This value is not reliable until the page has loaded or the contentsChanged event has fired.
    get_contentType: function()
    {
        this.LoadNewReportAreaVisibilityState();
        return this.m_contentTypeToMakeVisibleOnNextLoad;
    },

    // ContentChanged event - fires after the contents of the report area have changed and
    // are fully loaded.
    add_contentChanged: function(handler)
    {
        this.get_events().addHandler("contentChanged", handler);
    },
    remove_contentChanged: function(handler)
    {
        this.get_events().removeHandler("contentChanged", handler);
    },

    LoadNewReportAreaVisibilityState: function()
    {
        if (this.m_userCanceled)
        {
            // this is a specific form of "canceled", m_userCanceled is true if the report got sent to the client
            // and the user decided to cancel once images were loading. In that case, we've already been given new
            // data on what is in the report area, but it's now bad data because the user canceled. So instead,
            // tell everyone the report area is empty (which it is, the cancelling forced it to be).
            this.m_contentTypeToMakeVisibleOnNextLoad = Microsoft.Reporting.WebFormsClient.ReportAreaContent.None;
            this.m_isNewContentForNonReportContentArea = false;
        }
        else
        {
            var reportAreaVisibilityState = $get(this.ReportAreaVisibilityStateId);

            var newContentTypeAttr = reportAreaVisibilityState.attributes.getNamedItem("NewContentType");
            this.m_contentTypeToMakeVisibleOnNextLoad = eval(newContentTypeAttr.value);

            var nonReportContentAttr = reportAreaVisibilityState.attributes.getNamedItem("ForNonReportContentArea");
            this.m_isNewContentForNonReportContentArea = eval(nonReportContentAttr.value);
        }
    },

    SetRegionVisibility: function()
    {
        this.LoadNewReportAreaVisibilityState();
        this.SetSingleRegionVisibility(this.NonReportContentId, this.m_isNewContentForNonReportContentArea);
    },

    SetSingleRegionVisibility: function(regionElementId, makeVisible)
    {
        var regionElement = $get(regionElementId);
        if (makeVisible)
            regionElement.style.display = "";
        else
            regionElement.style.display = "none";
    },

    GetReportPage: function()
    {
        var reportElement = $get(this.ReportControlId);
        if (reportElement != null)
            return reportElement.control;
        else
            return null;
    },

    SwapReport: function()
    {
        var reportPage = this.GetReportPage();
        var visibleReportContentContainer = $get(this.VisibleReportContentContainerId);

        // If there is old report content
        if (visibleReportContentContainer.childNodes.length > 0)
        {
            // Save off scroll state before removing the old content
            if (this.CanScrollReportArea())
            {
                var scrollableArea = this.get_element();

                if (reportPage.AvoidScrollChange)
                {
                    this.m_previousScrollOffset = { Left: scrollableArea.scrollLeft, Top: scrollableArea.scrollTop };
                }
                else if (reportPage.PreviousViewNavigationAlignmentId != null && this.m_lastReportCellId != null)
                {
                    // Get the old target position and zoom rate
                    var previousZoom = reportPage.GetZoomFromReportCell(this.m_lastReportCellId);
                    var alignmentTargetOffset = this.CalculateElementOffset(reportPage.PreviousViewNavigationAlignmentId, previousZoom);

                    // Calculate the old offset within the viewport
                    var previousViewportOffsetLeft = alignmentTargetOffset.Left - scrollableArea.scrollLeft;
                    var previousViewportOffsetTop = alignmentTargetOffset.Top - scrollableArea.scrollTop;
                    this.m_previousViewportOffset = { Left: previousViewportOffsetLeft, Top: previousViewportOffsetTop };
                }
            }

            // Remove the old content
            var currentVisibleContent = visibleReportContentContainer.childNodes[0];
            visibleReportContentContainer.removeChild(currentVisibleContent);
        }

        // Have new content to render
        if (reportPage.ReportDivId != null)
        {
            var reportContent = $get(reportPage.ReportDivId);
            var reportParent = reportContent.parentNode;

            reportParent.removeChild(reportContent);
            if (visibleReportContentContainer.style.display == "none")
                visibleReportContentContainer.style.display = "";
            visibleReportContentContainer.appendChild(reportContent);
        }
        else if (visibleReportContentContainer.style.display == "")
            visibleReportContentContainer.style.display = "none";

    },

    ScrollToTarget: function()
    {
        var reportPage = this.GetReportPage();

        // If the report area scroll independently, scroll only that area
        if (this.CanScrollReportArea())
        {
            var newScrollTop = 0;
            var newScrollLeft = 0;
            var zoomRate = 1;

            if (reportPage.NavigationId != null)
            {
                // AvoidScrollingFromOrigin (e.g. new search page)
                if (reportPage.AvoidScrollFromOrigin)
                {
                    this.BringElementIntoView(reportPage.NavigationId, { Left: 0, Top: 0 });
                    return;
                }

                // AvoidScrolling (e.g. first search hit and it's on the current page)
                else if (this.m_previousScrollOffset != null)
                {
                    this.BringElementIntoView(reportPage.NavigationId, this.m_previousScrollOffset);
                    return;
                }

                // MaintainPosition with target / AlignedToTopLeft
                else
                {
                    // Align to top left (e.g. bookmark / docmap)
                    var targetElementOffset = this.CalculateElementOffset(reportPage.NavigationId, reportPage.GetCurrentZoomFactor());
                    newScrollTop = targetElementOffset.Top;
                    newScrollLeft = targetElementOffset.Left;

                    // MaintainPosition with target (e.g. toggle / sort) 
                    if (this.m_previousViewportOffset != null)
                    {
                        newScrollLeft -= this.m_previousViewportOffset.Left;
                        newScrollTop -= this.m_previousViewportOffset.Top;
                    }
                }
            }

            // Maintain position without target (e.g. no more search hits)
            else if (this.m_previousScrollOffset != null)
            {
                newScrollTop = this.m_previousScrollOffset.Top;
                newScrollLeft = this.m_previousScrollOffset.Left;
            }

            // Scroll to a specific pixel position (e.g. back from drillthrough, auto refresh)
            else if (reportPage.SpecificScrollPosition != null)
            {
                var scrollPosition = this._DeserializeScrollPosition(reportPage.SpecificScrollPosition);

                newScrollTop = scrollPosition.y;
                newScrollLeft = scrollPosition.x;
            }

            // Return to origin (e.g. standard page navigation)
            else
                ;

            // Scroll position can be of type float due to zoom rate
            newScrollLeft = parseInt(newScrollLeft);
            newScrollTop = parseInt(newScrollTop);
            this.set_scrollPosition(new Sys.UI.Point(newScrollLeft, newScrollTop));
        }
        else if (reportPage.NavigationId != null)
        {
            this.ScrollWebForm(reportPage.NavigationId);
        }
    },

    CanScrollReportArea: function()
    {
        var reportAreaElement = this.get_element();
        return reportAreaElement.style.overflow === "auto";
    },

    ScrollWebForm: function(navigationId)
    {
        window.location.replace("#" + navigationId);
    },

    CalculateElementOffset: function(elementId, zoomRate)
    {
        var scrollableArea = this.get_element();
        var iterator = $get(elementId);

        var totalTop = 0;
        var totalLeft = 0;

        // Sum the offsets until reaching the scroll container to find the total offset.
        // Firefox skips the visible container and goes straight to the table cell.
        while (iterator != null && iterator != scrollableArea && iterator != scrollableArea.parentNode)
        {
            totalTop += iterator.offsetTop;
            totalLeft += iterator.offsetLeft;

            iterator = iterator.offsetParent;
        }

        return { Left: totalLeft * zoomRate, Top: totalTop * zoomRate };
    },

    BringElementIntoView: function(elementId, initialScrollPosition)
    {
        var scrollableArea = this.get_element();
        var reportPage = this.GetReportPage();

        if (initialScrollPosition == null)
            initialScrollPosition = { Left: scrollableArea.scrollLeft, Top: scrollableArea.scrollTop };

        // Get the visible extents
        var visibleWidth = scrollableArea.offsetWidth;
        var visibleHeight = scrollableArea.offsetHeight;

        // Get the element position
        var elementPosition = this.CalculateElementOffset(elementId, reportPage.GetCurrentZoomFactor());

        // Assume the element is visible
        var newScrollTop = initialScrollPosition.Top;
        var newScrollLeft = initialScrollPosition.Left;

        // Check horizontal visibility
        if (newScrollLeft > elementPosition.Left || (newScrollLeft + visibleWidth) < elementPosition.Left)
        {
            // Set to centered
            newScrollLeft = elementPosition.Left - visibleWidth / 2;
        }

        // Check vertical visibility
        if (newScrollTop > elementPosition.Top || (newScrollTop + visibleHeight) < elementPosition.Top)
        {
            // Set to 1/3 down from the top
            newScrollTop = elementPosition.Top - visibleHeight / 3;
        }

        scrollableArea.scrollTop = newScrollTop;
        scrollableArea.scrollLeft = newScrollLeft;
    },

    HighlightNextSearchHit: function()
    {
        // Safety check for existence since this instance isn't called based off of an event on the report object
        var reportPage = this.GetReportPage();
        if (reportPage == null)
            return true;

        var targetId = reportPage.HighlightNextSearchHit();
        if (targetId == null)
            return false;

        if (this.CanScrollReportArea())
            this.BringElementIntoView(targetId, null);
        else
            this.ScrollWebForm(targetId);

        return true;
    },

    get_zoomLevel: function()
    {
        var reportPage = this.GetReportPage();
        if (reportPage != null)
            return reportPage.get_zoomLevel();
        else
            return 100;
    },

    set_zoomLevel: function(zoomValue)
    {
        // Safety check for existence since this instance isn't called based off of an event on the report object
        var reportPage = this.GetReportPage();
        if (reportPage != null)
            reportPage.set_zoomLevel(zoomValue);
    },

    OnScroll: function()
    {
        // FixedHeaders
        var reportPage = this.GetReportPage();
        if (reportPage)
        {
            reportPage.OnScroll();
        }

        // Keep track of the scroll position for the server control
        var serializedScrollPos = this._SerializeScrollPosition(this.get_scrollPosition());
        var scrollHiddenField = $get(this.ScrollPositionId);
        scrollHiddenField.value = serializedScrollPos;

        this.raisePropertyChanged("scrollPosition");
    },

    _OnUserCanceled: function()
    {
        this.m_userCanceled = true;
        
        var reportPage = this.GetReportPage();
        if(reportPage)
            reportPage._OnUserCanceled();
    },

    _DeserializeScrollPosition: function(serializedValue)
    {
        var top = 0;
        var left = 0;

        // Split the string
        var values = serializedValue.split(" ");
        if (values.length == 2)
        {
            // Parse the individual values as ints

            var i = parseInt(values[0], 10);
            if (!isNaN(i))
                left = i;

            i = parseInt(values[1], 10);
            if (!isNaN(i))
                top = i;
        }

        return new Sys.UI.Point(left, top);
    },

    _SerializeScrollPosition: function(scrollPoint)
    {
        return scrollPoint.x + " " + scrollPoint.y;
    },

    EnableDisableInput: function(shouldEnable)
    {
        var reportPage = this.GetReportPage();
        if (reportPage)
            reportPage.EnableDisableInput(shouldEnable);
    }
}

Microsoft.Reporting.WebFormsClient._ReportArea.registerClass("Microsoft.Reporting.WebFormsClient._ReportArea", Sys.UI.Control);

Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget = function(element)
{
    Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.initializeBase(this, [element]);
    
    this.PostBackForAsyncLoad = null;
    this.m_asyncLoadDelegate = Function.createDelegate(this, this.TriggerPostBack);
    this.m_onAppLoadDelegate = Function.createDelegate(this, this.OnAppLoad);
    this.m_postBackTriggered = false;
}

Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.prototype = 
{
    initialize : function()
    {
        Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.callBaseMethod(this, "initialize");

        // Ensures that only one report viewer on the page causes a postback for async rendering.
        // Otherwise, multiple postback requests will be initiated and aborted if multiple async viewers
        // are on a single webform.
        if (!Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.AsyncTriggerSelected)
        {
            Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.AsyncTriggerSelected = true;

            Sys.Application.add_load(this.m_onAppLoadDelegate);
        }
    },

    dispose : function()
    {
        if (this.m_asyncLoadDelegate != null)
        {
            Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.AsyncTriggerSelected = false;

            delete this.m_asyncLoadDelegate;
            this.m_asyncLoadDelegate = null;
        }

        if (this.m_onAppLoadDelegate != null)
        {
            Sys.Application.remove_load(this.m_onAppLoadDelegate);
            
            delete this.m_onAppLoadDelegate;
            this.m_onAppLoadDelegate = null;
        }

        Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.callBaseMethod(this, "dispose");
    },
    
    OnAppLoad : function()
    {
        if (!this.m_postBackTriggered)
        {
            // Call async load on a timer to ensure that the entire Sys.Application.load event is executed
            // before triggering another postback.  During async postbacks, initialize gets called in its
            // own setTimeout, so this timer can't be fired until actually in the Sys.Application.load event.
            setTimeout(this.m_asyncLoadDelegate, 0);
        }
    },
    
    TriggerPostBack : function()
    {
        // Ensure only one async load target caused a postback.  Dispose should take care of this, but
        // check for safety in case of errors on the client.
        if (!this.m_postBackTriggered)
        {
            var isInAsyncPostBack = false;
            if (Sys.WebForms)
            {
                var pageRequestManager = Sys.WebForms.PageRequestManager.getInstance();
                isInAsyncPostBack = pageRequestManager.get_isInAsyncPostBack();
            }
            
            // Ensure nothing else caused an async postback already
            if (!isInAsyncPostBack)
            {
                this.PostBackForAsyncLoad();
                this.m_postBackTriggered = true;
                Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.AsyncTriggerSelected = false;
            }
        }
    }    
}

Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.registerClass("Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget", Sys.UI.Control);
﻿Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._ReportPage = function(element)
{
    Microsoft.Reporting.WebFormsClient._ReportPage.initializeBase(this, [element]);

    // Script methods to invoke sync or async postbacks for interactivity
    this.TriggerSyncInteractivity = null;
    this.TriggerAsyncInteractivity = null;
    this.InteractivityMode = null;

    // Hidden fields to store interactivity info during the postback
    this.ActionTypeId = null;
    this.ActionParamId = null;

    this.SearchHitPrefix = null;
    this.m_nextSearchHit = 1;

    this.NavigationId = null;

    // MaintainPosition
    this.PreviousViewNavigationAlignmentId = null; // Try to align this.NavigationId to this id from the old page.

    // AvoidScrolling
    this.AvoidScrollChange = false;
    this.AvoidScrollFromOrigin = false;

    // Specific position scrolling
    this.SpecificScrollPosition = null;

    this.HiddenZoomLevelId = null;
    this.LoadMessage = null;

    this.ReportDivId = null;
    this.ReportCellId = null;
    this.ScrollableContainerId = null;

    this.m_allContentLoaded = false;
    this.m_loadDelegate = Function.createDelegate(this, this._PollForAllContentLoaded);

    this.ReportStyles = null;
    this.ReportPageStyles = null;
    this.StyleElementId = null;

    this.PrefixId = null;

    this.ScrollScript = null;
    this.m_fixedHeader = null;

    this.m_executingAction = null;
    this.m_toolbarUpdate = null;

    this.ConstFullPage = "FullPage";
    this.ConstPageWidth = "PageWidth";

    this.m_userCanceled = false;
}

Microsoft.Reporting.WebFormsClient._ReportPage.prototype =
{
    initialize: function()
    {
        Microsoft.Reporting.WebFormsClient._ReportPage.callBaseMethod(this, "initialize");

        // Don't update the DOM until the load event (causes a race condition in Firefox
        // with hash based scrolling between the location.replace and the browser page update).
        Sys.Application.add_load(this.m_loadDelegate);
    },

    dispose: function()
    {
        Sys.Application.remove_load(this.m_loadDelegate);
        delete this.m_loadDelegate;

        Microsoft.Reporting.WebFormsClient._ReportPage.callBaseMethod(this, "dispose");
    },

    // Custom accessor for complex object type (array)
    set_ToolBarUpdate: function(value) { this.m_toolbarUpdate = value; },
    get_ToolBarUpdate: function() { return this.m_toolbarUpdate; },

    // AllContentLoaded event - indicates that all content is loaded (may be none if there is no actual report page)
    add_allContentLoaded: function(handler)
    {
        this.get_events().addHandler("allContentLoaded", handler);
    },
    remove_allContentLoaded: function(handler)
    {
        this.get_events().removeHandler("allContentLoaded", handler);
    },

    IsLoading: function()
    {
        return !this.m_allContentLoaded;
    },

    _OnUserCanceled: function()
    {
        this.m_userCanceled = true;
    },

    _PollForAllContentLoaded: function()
    {
        if (this.m_userCanceled)
        {
            // user has decided to cancel loading this report, so force the browsers to stop loading the images
            if (this.ReportDivId)
            {
                var reportDiv = $get(this.ReportDivId);

                if (reportDiv)
                {
                    // this will force IE and FireFox to stop loading all
                    // images from the reportDiv on down
                    reportDiv.innerHTML = "";
                }
            }

            return;
        }

        // Validate that the report content is loaded if there is report content
        if (this.ReportDivId != null)
        {
            // A report page is not loaded until all of the images are
            var reportDiv = $get(this.ReportDivId);

            // It's possible for the user to cause postbacks so rapidly that this method
            // is being called against the nth postback while the nth+1's ReportDiv has been
            // loaded. This will lead to a null ref exception against reportDiv, as this
            // code is trying to load a ReportDiv that no longer exists.
            // This happens very rarely, and only under ideal conditions when postbacks
            // can be triggered very rapidly. But still checking if we actually got a report div
            // here just to be safe.
            if (reportDiv)
            {
                var images = reportDiv.getElementsByTagName("IMG");

                for (var i = 0; i < images.length; i++)
                {
                    var img = images[i];
                    if (!img.complete && !img.errored)
                    {
                        setTimeout(Function.createDelegate(this, this._PollForAllContentLoaded), 250);
                        return;
                    }
                }
            }
        }

        this._OnAllContentLoaded();
    },

    _OnAllContentLoaded: function()
    {
        if (this.m_allContentLoaded)
            return;
        this.m_allContentLoaded = true;

        // Raise content changed event
        var handler = this.get_events().getHandler("allContentLoaded");
        if (handler)
            handler(this);
    },

    OnReportVisible: function()
    {
        this._OutputStyleStream();
        this._UpdateRenderer();
        this._ApplyZoom(this.get_zoomLevel());
    },

    _OutputStyleStream: function()
    {
        var headElementsCollection = document.getElementsByTagName("HEAD");
        var headElement = null;

        // Ensure the HEAD element exists.  If not, create one.
        if (headElementsCollection.length == 0)
        {
            headElement = document.createElement("HEAD");
            document.documentElement.insertBefore(headElement, document.documentElement.firstChild);
        }
        else
            headElement = headElementsCollection[0];

        var oldStyleElement = document.getElementById(this.StyleElementId);

        // Remove the current STYLE element, if it already exists.
        if (oldStyleElement != null)
            headElement.removeChild(oldStyleElement);

        if (this.ReportDivId)
        {
            var reportDiv = $get(this.ReportDivId);
            var pageStyleContainerId = reportDiv.parentNode.id;
            if (pageStyleContainerId)
            {
                var pageStyles = this.ReportPageStyles;
                if (!pageStyles)
                    pageStyles = "";
                var pageStyle = "#" + pageStyleContainerId + " { " + pageStyles + "}";
                if (this.ReportStyles)
                    this.ReportStyles += pageStyle;
                else
                    this.ReportStyles = pageStyle;

                // When the viewer had an iFrame,
                // fonts would fall back to Times New Roman as that is the browser default. 
                // Now that we render as part of the page, they fall back to whatever
                // is defind in the stylesheet for the page, in the case of
                // ReportManager/Server, that is verdana. We want to maintain
                // falling back to Times New Roman, so inject that font style here
                // if an element in the report specifies a font that can't be found,
                // the browser will work up the parent chain and get here to find TNR
                this.ReportStyles += " #" + this.ReportDivId + ", #" + this.ReportDivId + " TABLE { font-family: Times New Roman; }";
            }
        }

        // If we have any styles, create a STYLE element
        // using the styles and place it in the page head.
        if (this.ReportStyles != null)
        {
            var newStyleElement = document.createElement("STYLE");
            newStyleElement.type = "text/css";
            newStyleElement.id = this.StyleElementId;

            if (newStyleElement.styleSheet != null)
                newStyleElement.styleSheet.cssText = this.ReportStyles;
            else
                newStyleElement.appendChild(document.createTextNode(this.ReportStyles));

            headElement.appendChild(newStyleElement);
        }

    },

    OnReportScrolled: function()
    {
        if (this.LoadMessage != null)
            alert(this.LoadMessage);
    },

    InvokeReportAction: function(actionType, actionParam)
    {
        if (!this._IsInputDisabled())
        {
            // Save interactivity info for postback
            $get(this.ActionTypeId).value = actionType;
            $get(this.ActionParamId).value = this._TranslateAction(actionType, actionParam);

            if (this.InteractivityMode === "AlwaysSynchronous" ||
                (this.InteractivityMode === "SynchronousOnDrillthrough" && actionType === "Drillthrough"))
            {
                this.TriggerSyncInteractivity();
            }
            else
                this.TriggerAsyncInteractivity();
        }
    },

    HighlightNextSearchHit: function()
    {
        if (this.SearchHitPrefix == null)
            return null;

        // Unhighlight previous hit, if any.
        if (this.m_nextSearchHit > 0)
        {
            var name = this.SearchHitPrefix + (this.m_nextSearchHit - 1);
            var hitElem = $get(name);
            var count = 0;
            // Clean up the background for a find across multiple textRuns
            while (hitElem != null)
            {
                hitElem.style.backgroundColor = "";
                hitElem.style.color = "";
                hitElem = $get(name + "_" + (++count));
            }
        }

        // Highlight current hit and navigate to it.
        var name = this.SearchHitPrefix + (this.m_nextSearchHit);
        var hitElem = $get(name);
        if (hitElem == null)
            return null;
        var count = 0;
        // Clean up the background for a find across multiple textRuns
        while (hitElem != null)
        {
            hitElem.style.backgroundColor = "highlight";
            hitElem.style.color = "highlighttext";
            hitElem = $get(name + "_" + (++count));
        }

        this.m_nextSearchHit++;

        // Return the navigation target
        return name;
    },

    _ApplyZoom: function(zoomValue)
    {
        // Get the report cell
        if (this.ReportCellId == null)
            return;
        var reportCell = $get(this.ReportCellId);

        if ((zoomValue != this.ConstPageWidth) && (zoomValue != this.ConstFullPage))
            reportCell.style.zoom = zoomValue + "%";
        else
        {
            var scrollContainer = $get(this.ScrollableContainerId);
            if (scrollContainer == null || scrollContainer.style.overflow != "auto")
                return;

            if (zoomValue != this.ConstPageWidth)
            {
                if ((reportCell.offsetWidth * scrollContainer.offsetHeight) < (reportCell.offsetHeight * scrollContainer.offsetWidth))
                    this._ApplyCalculatedZoom(reportCell, scrollContainer.offsetHeight, reportCell.offsetHeight);
                else
                    this._ApplyCalculatedZoom(reportCell, scrollContainer.offsetWidth, reportCell.offsetWidth);
            }
            else
            {
                var vbar = scrollContainer.offsetHeight != scrollContainer.clientHeight;
                var proceed = (reportCell.offsetWidth > 0);
                for (var iter = 0; (iter <= 1) & proceed; ++iter)
                {
                    zoomValue = this._ApplyCalculatedZoom(reportCell, scrollContainer.clientWidth, reportCell.offsetWidth);
                    proceed = vbar != ((reportCell.offsetHeight * zoomValue) > scrollContainer.offsetHeight);
                }
            }
        }

        //Recalc imageconsolidation for IE7.  
        //IE7 standards uses absolutely positioned images that need to scale with zoom.
        //IE7/8 quirks and IE8 standards automatically scale the images.
        if (Microsoft_ReportingServices_HTMLRenderer_ScaleImageUpdateZoom)
        {
            if (_$RVCommon.isPreIE8StandardsMode())
            {
                var fitProp = new Microsoft_ReportingServices_HTMLRenderer_FitProportional();
                fitProp.ResizeImages(this.ReportDivId, this.ReportCellId);
                Microsoft_ReportingServices_HTMLRenderer_ScaleImageUpdateZoom(this.ReportDivId, this.ReportCellId);
            }
        }

        this.OnScroll();
    },

    // Set a zoom value that is calculated based on the report width/height
    _ApplyCalculatedZoom: function(reportCell, div, rep)
    {
        if (rep <= 0)
            return 1.0;
        var z = (div - 1) / rep;
        reportCell.style.zoom = z;
        return z;
    },

    // Gets the actual current zoom value as a fraction (1.0, 2.0, etc) regardless of whether
    // the zoom mode is percentage or FullPage/PageWidth
    GetCurrentZoomFactor: function()
    {
        return this.GetZoomFromReportCell(this.ReportCellId);
    },

    GetZoomFromReportCell: function(cellId)
    {
        var reportCell = $get(cellId);

        // If very rapid postbacks are occuring, it's possible
        // to end up in a situation where cellId refers to an element
        // that no longer exists (it's been replaced with new content and
        // the script descriptors have not ran to update the client side objects)
        // so checking if reportCell is null before proceeding here.
        if (reportCell)
        {
            var zoomStr = reportCell.style.zoom;
            if (zoomStr != "" && zoomStr != null)
            {
                zoomStr = zoomStr.substr(0, zoomStr.length - 1); // Remove % sign
                return zoomStr / 100.0;
            }
        }

        return 1.0;
    },

    get_zoomLevel: function()
    {
        var hiddenZoomLevelElement = $get(this.HiddenZoomLevelId);
        return hiddenZoomLevelElement.value;
    },

    set_zoomLevel: function(newZoomLevel)
    {
        // Validate newZoomLevel
        if (newZoomLevel != this.ConstPageWidth && newZoomLevel != this.ConstFullPage)
        {
            // Validate percentage zoom
            var newZoomAsInt = parseInt(newZoomLevel, 10)
            if (isNaN(newZoomAsInt) || newZoomAsInt <= 0)
                throw Error.argumentOutOfRange("zoomLevel", newZoomLevel, "The zoom level must be a positive integer or '" + this.ConstPageWidth + "' or '" + this.ConstFullPage + "'.");
            else
                newZoomLevel = newZoomAsInt; // Normalize the value
        }

        // Apply the zoom value
        this._ApplyZoom(newZoomLevel);

        // Save the value for the postback
        var hiddenZoomLevelElement = $get(this.HiddenZoomLevelId);
        hiddenZoomLevelElement.value = newZoomLevel;
    },

    //FitProportional
    _UpdateRenderer: function()
    {
        if (this.ReportDivId)
        {
            var fitProp = new Microsoft_ReportingServices_HTMLRenderer_FitProportional();
            fitProp.ResizeImages(this.ReportDivId, this.ReportCellId);

            if (Microsoft_ReportingServices_HTMLRenderer_GrowTablixTextBoxes)
                Microsoft_ReportingServices_HTMLRenderer_GrowTablixTextBoxes(this.ReportDivId);

            if (Microsoft_ReportingServices_HTMLRenderer_ScaleImageConsolidation)
                Microsoft_ReportingServices_HTMLRenderer_ScaleImageConsolidation(this.ReportDivId, this.ReportCellId);

            if (Microsoft_ReportingServices_HTMLRenderer_ScaleImageForFit)
                Microsoft_ReportingServices_HTMLRenderer_ScaleImageForFit(this.ReportDivId);

            if (Microsoft_ReportingServices_HTMLRenderer_GrowRectangles)
                Microsoft_ReportingServices_HTMLRenderer_GrowRectangles(this.ReportDivId);

            if (Microsoft_ReportingServices_HTMLRenderer_FitVertText)
                Microsoft_ReportingServices_HTMLRenderer_FitVertText(this.ReportDivId);
        }
    },

    OnScroll: function()
    {
        if (this.ScrollScript)
        {
            var firstTime = !this.m_fixedHeader;
            if (firstTime)
            {
                this.m_fixedHeader = new Microsoft_ReportingServices_HTMLRenderer_FixedHeader(this.ReportDivId, this.ReportCellId,
                    $get(this.ReportDivId).parentNode.id, this.PrefixId);
            }
            this.ScrollScript(firstTime);
        }
    },

    EnableDisableInput: function(shouldEnable)
    {
        if (shouldEnable)
            this.m_executingAction = null;
        else
            this.m_executingAction = true;
    },

    _IsInputDisabled: function()
    {
        return this.m_executingAction == true;
    },

    _TranslateAction: function(actionType, actionParam)
    {
        var completeActionParam;
        if (actionType == "Sort")
        {
            if (window.event && window.event.shiftKey)
                completeActionParam = actionParam + "_T";
            else
                completeActionParam = actionParam + "_F";
        }
        else
            completeActionParam = actionParam;

        return completeActionParam;
    }
}

Microsoft.Reporting.WebFormsClient._ReportPage.registerClass("Microsoft.Reporting.WebFormsClient._ReportPage", Sys.UI.Control);

﻿Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._SessionKeepAlive = function()
{
    Microsoft.Reporting.WebFormsClient._SessionKeepAlive.initializeBase(this);

    this.KeepAliveUrl = null;
    this.KeepAliveBody = null;
    this.KeepAliveIntervalSeconds = 0;

    this.m_keepAliveTimerId = null;
    this.m_executingKeepAlive = null;

    this.m_isInitialized = false;

    this.m_onTimerIntervalDelegate = Function.createDelegate(this, this.KeepSessionsAlive);
    this.m_onKeepAliveRequestCompletedDelegate = Function.createDelegate(this, this.OnKeepAliveRequestCompleted);

    this.m_onAppLoadDelegate = Function.createDelegate(this, this.OnAppLoad);
}

Microsoft.Reporting.WebFormsClient._SessionKeepAlive.prototype =
{
    initialize: function()
    {
        Microsoft.Reporting.WebFormsClient._SessionKeepAlive.callBaseMethod(this, "initialize");

        // Need to wait until app load to avoid async calls colliding with async postback
        Sys.Application.add_load(this.m_onAppLoadDelegate);
    },

    dispose: function()
    {
        this.CancelKeepAliveTimer();

        if (this.m_executingKeepAlive != null)
            this.m_executingKeepAlive.abort();

        delete this.m_onTimerIntervalDelegate;
        this.m_onTimerIntervalDelegate = null;

        delete this.m_onKeepAliveRequestCompletedDelegate;
        this.m_onKeepAliveRequestCompletedDelegate = null;

        Sys.Application.remove_load(this.m_onAppLoadDelegate);
        delete this.m_onAppLoadDelegate;
        this.m_onAppLoadDelegate = null;

        Microsoft.Reporting.WebFormsClient._SessionKeepAlive.callBaseMethod(this, "dispose");
    },

    OnAppLoad: function()
    {
        if (this.m_isInitialized)
            return;

        if (this.KeepAliveIntervalSeconds != 0)
        {
            this.KeepSessionsAlive();
            this.m_keepAliveTimerId = setInterval(this.m_onTimerIntervalDelegate, this.KeepAliveIntervalSeconds * 1000);
        }

        this.m_isInitialized = true;
    },

    KeepSessionsAlive: function()
    {
        // Don't ping twice simultaneously
        if (this.m_executingKeepAlive != null)
            return;

        var webRequest = new Sys.Net.WebRequest();
        webRequest.set_url(this.KeepAliveUrl);
        webRequest.set_httpVerb("POST");
        if (this.KeepAliveBody != null)
        {
            webRequest.set_body(this.KeepAliveBody);
            // WebKit doesn't allow to set Content-Length explicitly due security reasons.
            // Content lenght will be determined and set based on actual body length.
            if ( Sys.Browser.agent != Sys.Browser.Safari )
            {
                webRequest.get_headers()["Content-Length"] = this.KeepAliveBody.length;
            }
        }
        webRequest.add_completed(this.m_onKeepAliveRequestCompletedDelegate);

        webRequest.invoke();
        this.m_executingKeepAlive = webRequest.get_executor();
    },

    OnKeepAliveRequestCompleted: function(executor, eventArgs)
    {
        this.m_executingKeepAlive = null;

        if (executor.get_timedOut() || (executor.get_responseAvailable() && executor.get_statusCode() != 200))
        {
            this.CancelKeepAliveTimer();
        }
    },

    CancelKeepAliveTimer: function()
    {
        if (this.m_keepAliveTimerId != null)
        {
            clearTimeout(this.m_keepAliveTimerId);
            this.m_keepAliveTimerId = null;
        }
    }
}

Microsoft.Reporting.WebFormsClient._SessionKeepAlive.registerClass("Microsoft.Reporting.WebFormsClient._SessionKeepAlive", Sys.Component);
Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._ScriptSwitchImage = function(element)
{
    Microsoft.Reporting.WebFormsClient._ScriptSwitchImage.initializeBase(this, [element]);
    
    this.Image1Id = null;
    this.Image2Id = null;
}

Microsoft.Reporting.WebFormsClient._ScriptSwitchImage.prototype = 
{
    ShowImage : function(shouldShowImage1)
    {
        var image1 = $get(this.Image1Id);
        var image2 = $get(this.Image2Id);
        if (image1 == null || image2 == null)
            return;

        if (shouldShowImage1)
        {
            image1.style.display = "";
            image2.style.display = "none";
        }
        else
        {
            image2.style.display = "";
            image1.style.display = "none";
        }
    },
    
    SetOnClickHandler : function(forImage1, handler)
    {
        var image;
        if (forImage1)
            image = $get(this.Image1Id);
        else
            image = $get(this.Image2Id);
            
        image.control.OnClickScript = handler;
    }
}

Microsoft.Reporting.WebFormsClient._ScriptSwitchImage.registerClass("Microsoft.Reporting.WebFormsClient._ScriptSwitchImage", Sys.UI.Control);
Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._TextButton = function(element)
{
    Microsoft.Reporting.WebFormsClient._TextButton.initializeBase(this, [element]);

    this.IsActive = false;
    this.OnClickScript = null;

    this.ActiveLinkStyle = null;
    this.DisabledLinkStyle = null;

    this.ActiveLinkColor = null;
    this.DisabledLinkColor = null;
    this.ActiveHoverLinkColor = null;
}

Microsoft.Reporting.WebFormsClient._TextButton.prototype = 
{
    initialize : function()
    {
        Microsoft.Reporting.WebFormsClient._TextButton.callBaseMethod(this, "initialize");

        $addHandlers(this.get_element(),
            { "mouseover" : this.OnMouseOver,
              "mouseout"  : this.OnMouseOut,
              "click"     : this.OnClick },
            this);

        this.OnMouseOut(null);
    },
    
    dispose : function()
    {
        $clearHandlers(this.get_element());
        
        Microsoft.Reporting.WebFormsClient._TextButton.callBaseMethod(this, "dispose");
    },
    
    OnMouseOver : function(e)
    {
        if (this.ActiveLinkStyle != null)
            return;
            
        var link = this.get_element();

        if (this.IsActive)
        {
            link.style.textDecoration = "underline";
            link.style.color = this.ActiveHoverLinkColor;
            link.style.cursor = "pointer";
        }
        else
            link.style.cursor = "default";
    },
    
    OnMouseOut : function(e)
    {
        if (this.ActiveLinkStyle != null)
            return;

        var link = this.get_element();

        if (this.IsActive)
            link.style.color = this.ActiveLinkColor;
        else
            link.style.color = this.DisabledLinkColor;
        link.style.textDecoration = "none";
    },
    
    OnClick : function(e)
    {
        if (this.OnClickScript != null && this.IsActive)
            this.OnClickScript();

        e.preventDefault();
    },
    
    SetActive : function(makeActive)
    {
        var button = this.get_element();
            
        this.IsActive = makeActive;
        
        // If using styles, update style name
        if (this.ActiveLinkStyle != null)
        {
            if (this.IsActive)
                button.className = this.ActiveLinkStyle;
            else
                button.className = this.DisabledLinkStyle;
        }
        
        this.OnMouseOut(null);
    }
}

Microsoft.Reporting.WebFormsClient._TextButton.registerClass("Microsoft.Reporting.WebFormsClient._TextButton", Sys.UI.Control);
﻿Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._Toolbar = function(element)
{
    Microsoft.Reporting.WebFormsClient._Toolbar.initializeBase(this, [element]);

    this.m_reportViewer = null;
    this.m_onReportViewerLoadingChangedDelegate = Function.createDelegate(this, this.OnReportViewerLoadingChanged);
    this.m_onReportAreaContentChangedDelegate = Function.createDelegate(this, this.OnReportAreaContentChanged);

    // Page Nav
    this.CurrentPage = 0;
    this.TotalPages = 0;
    this.IsEstimatePageCount = true;
    this.CurrentPageId = null;
    this.TotalPagesId = null;
    this.FirstPageNavId = null;
    this.PrevPageNavId = null;
    this.NextPageNavId = null;
    this.LastPageNavId = null;
    this.InvalidPageNumberMessage = null;
    this.OnCurrentPageClick = null;

    // Drillthrough Back
    this.IsDrillthroughReport = false;
    this.DrillBackId = null;

    // Refresh
    this.RefreshId = null;
    this.m_onRefreshClickDelegate = Function.createDelegate(this, this.OnRefreshClick);

    // Zoom
    this.ZoomId = null;
    this.m_zoomSelectionChangeDelegate = Function.createDelegate(this, this.OnZoomSelectionChanged);
    this.m_externalZoomChangeDelegate = Function.createDelegate(this, this.OnZoomChangedExternal);

    // Find
    this.FindTextBoxId = null;
    this.FindButtonId = null;
    this.FindNextButtonId = null;
    this.CanFindNext = false;
    this.FindTextBoxPollInterval = null;
    this.m_onFindTextChangeDelegate = Function.createDelegate(this, this.OnFindTextChanged);
    this.m_onFindTextFocusDelegate = Function.createDelegate(this, this.OnFindTextFocus);
    this.m_onFindTextBlurDelegate = Function.createDelegate(this, this.OnFindTextBlur);
    this.m_enableDisableFindButtonsDelegate = Function.createDelegate(this, this.CheckEnableDisableFindButtons);
    this.m_onFindClickDelegate = Function.createDelegate(this, this.OnFindClick);
    this.m_onFindNextClickDelegate = Function.createDelegate(this, this.OnFindNextClick);

    // Export
    this.ExportFormatsId = null;
    this.ExportButtonId = null;
    this.m_onExportFormatChangeDelegate = Function.createDelegate(this, this.OnExportFormatChanged);
    this.m_onExportClickDelegate = Function.createDelegate(this, this.OnExportClick);

    // Print
    this.PrintId = null;
    this.m_onPrintClickDelegate = Function.createDelegate(this, this.OnPrintClick);

    this.m_isFirstEnable = true;
}

Microsoft.Reporting.WebFormsClient._Toolbar.prototype =
{
    initialize: function()
    {
        Microsoft.Reporting.WebFormsClient._Toolbar.callBaseMethod(this, "initialize");

        // Assumes viewer was created first
        this.m_reportViewer.add_propertyChanged(this.m_onReportViewerLoadingChangedDelegate);
        this.m_reportViewer.add_propertyChanged(this.m_onReportAreaContentChangedDelegate);

        // Don't postback the zoom dropdown.  It isn't used on the server and can cause event
        // validation to fail in some cases, such as when a custom value is added to the dropdown
        // on the client.
        if (this.ZoomId != null)
        {
            var zoomDropDown = $get(this.ZoomId);
            if (zoomDropDown != null)
                zoomDropDown.name = null;
        }
    },

    dispose: function()
    {
        if (this.FindTextBoxPollInterval != null)
        {
            clearInterval(this.FindTextBoxPollInterval);
        }

        Microsoft.Reporting.WebFormsClient._Toolbar.callBaseMethod(this, "dispose");

        // Disconnect from the report viewer
        if (this.m_reportViewer != null)
        {
            this.m_reportViewer.remove_propertyChanged(this.m_onReportViewerLoadingChangedDelegate);
            this.m_reportViewer.remove_propertyChanged(this.m_onReportAreaContentChangedDelegate);
            this.m_reportViewer.remove_propertyChanged(this.m_externalZoomChangeDelegate);
        }

        if (this.CurrentPageId != null)
        {
            var currentPageTextBox = $get(this.CurrentPageId);
            if (currentPageTextBox != null)
                $clearHandlers(currentPageTextBox);
        }
        
        if (this.FindTextBoxId != null)
        {
            var findTextBox = $get(this.FindTextBoxId);
            if (findTextBox != null)
                $clearHandlers(findTextBox);
        }
        
        // Delete all the delegates
        if (this.m_onFindTextChangeDelegate != null)
        {
            delete this.m_onFindTextChangeDelegate;
            this.m_onFindTextChangeDelegate = null;

            delete this.m_onFindTextFocusDelegate;
            this.m_onFindTextFocusDelegate = null;

            delete this.m_onFindTextBlurDelegate;
            this.m_onFindTextBlurDelegate = null;

            delete this.m_enableDisableFindButtonsDelegate;
            this.m_enableDisableFindButtonsDelegate = null;

            delete this.m_onFindClickDelegate;
            this.m_onFindClickDelegate = null;

            delete this.m_onFindNextClickDelegate;
            this.m_onFindNextClickDelegate = null;

            delete this.m_onExportClickDelegate;
            this.m_onExportClickDelegate = null;

            delete this.m_onExportFormatChangeDelegate;
            this.m_onExportFormatChangeDelegate = null;

            delete this.m_zoomSelectionChangeDelegate;
            this.m_zoomSelectionChangeDelegate = null;

            delete this.m_externalZoomChangeDelegate;
            this.m_externalZoomChangeDelegate = null;

            delete this.m_onPrintClickDelegate;
            this.m_onPrintClickDelegate = null;

            delete this.m_onRefreshClickDelegate;
            this.m_onRefreshClickDelegate = null;

            delete this.m_onReportViewerLoadingChangedDelegate;
            this.m_onReportViewerLoadingChangedDelegate = null;

            delete this.m_onReportAreaContentChangedDelegate;
            this.m_onReportAreaContentChangedDelegate = null;
        }
    },

    set_ReportViewer: function(value)
    {
        this.m_reportViewer = value;
    },

    ConnectEventHandlers: function()
    {
        // PageNav
        if (this.CurrentPageId != null)
        {
            var currentPageTextBox = $get(this.CurrentPageId);
            
            if (currentPageTextBox != null)
            {
                $addHandlers(currentPageTextBox,
                    { "keypress": this.OnCurrentPageKeyPress },
                    this);
            }
        }
        
        // Find
        if (this.FindTextBoxId != null)
        {
            var findTextBox = $get(this.FindTextBoxId);
            if (findTextBox != null)
            {
                // onpropertychange is an IE only event, if it does not exist we use polling on onfocus instead.
                if (typeof findTextBox.onpropertychange != 'undefined')
                {
                    findTextBox.onpropertychange = this.m_onFindTextChangeDelegate;
                }
                else
                {
                    findTextBox.onfocus = this.m_onFindTextFocusDelegate;
                    findTextBox.onblur = this.m_onFindTextBlurDelegate;
                }

                $addHandlers(findTextBox,
                    { "keypress": this.OnFindTextKeyPress },
                    this);

                var findButton = $get(this.FindButtonId);
                findButton.control.OnClickScript = this.m_onFindClickDelegate;

                var findNextButton = $get(this.FindNextButtonId);
                findNextButton.control.OnClickScript = this.m_onFindNextClickDelegate;
            }
        }

        // Zoom
        if (this.ZoomId != null)
        {
            var zoomDropDown = $get(this.ZoomId);
            if (zoomDropDown != null)
            {
                zoomDropDown.onchange = this.m_zoomSelectionChangeDelegate;

                this.m_reportViewer.add_propertyChanged(this.m_externalZoomChangeDelegate);
            }
        }

        // Print
        if (this.PrintId != null)
        {
            var printButton = $get(this.PrintId);
            if (printButton != null)
                printButton.control.SetOnClickHandler(true, this.m_onPrintClickDelegate);
        }

        // Refresh
        if (this.RefreshId != null)
        {
            var refreshButton = $get(this.RefreshId)
            if (refreshButton != null)
                refreshButton.control.SetOnClickHandler(true, this.m_onRefreshClickDelegate);
        }
    },

    OnReportViewerLoadingChanged: function(sender, e)
    {
        if (e.get_propertyName() == "isLoading")
        {
            var isLoading = this.m_reportViewer.get_isLoading();

            this.EnableDisable(!isLoading);
        }
    },

    OnReportAreaContentChanged: function(sender, e)
    {
        if (e.get_propertyName() == "reportAreaContentType")
        {
            var updateProperties = this.m_reportViewer._get_toolBarUpdate();
            if (updateProperties != null)
                this.UpdateForNewReportPage(updateProperties);
        }
    },

    EnableDisable: function(forEnable)
    {
        if (forEnable)
        {
            if (this.m_isFirstEnable)
            {
                this.ConnectEventHandlers();
                this.m_isFirstEnable = false;
            }
        }

        // Enable/Disable UI elements.  If enabling and about to trigger a postback
        // (which would just disable things again), skip the enable.
        if (!forEnable || !Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.AsyncTriggerSelected)
        {
            var reportAreaContentType = Microsoft.Reporting.WebFormsClient.ReportAreaContent.None;
            if (forEnable)
            {
                // Only get the content type if we are enabling the toolbar.  Otherwise it isn't available yet.
                reportAreaContentType = this.m_reportViewer.get_reportAreaContentType();
            }
            var isDisplayingReportPage = reportAreaContentType == Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage;

            // this is a rather implicit way to determine if the user canceled a report rendering
            // if the viewer is no longer loading and the viewer has no content, then the only way that is possible is if the user
            // canceled the request.
            var canceled = !this.m_reportViewer.get_isLoading() && reportAreaContentType == Microsoft.Reporting.WebFormsClient.ReportAreaContent.None;

            // Drillthrough Back
            // it should be enabled if this is a drillthrough report and the whole toolbar is enabled or the viewer is in the canceled state
            var enableBack =
                (forEnable ||
                canceled) &&
                this.IsDrillthroughReport
            this.EnableDisableImage(this.DrillBackId, enableBack);

            // Refresh
            // should always be enabled if the user has put the viewer in a canceled state
            var enableRefresh =
                (forEnable &&
                (isDisplayingReportPage ||
                 reportAreaContentType == Microsoft.Reporting.WebFormsClient.ReportAreaContent.Error)) ||
                 canceled;
            this.EnableDisableImage(this.RefreshId, enableRefresh);

            // Page Nav
            var canPageNav = reportAreaContentType == Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage;
            var canPageNavBackward = canPageNav && this.CurrentPage > 1;
            var canPageNavForward = canPageNav && (this.CurrentPage < this.TotalPages || this.IsEstimatePageCount);
            this.EnableDisableWebControl(this.CurrentPageId, isDisplayingReportPage);
            this.EnableDisableImage(this.FirstPageNavId, isDisplayingReportPage && canPageNavBackward);
            this.EnableDisableImage(this.PrevPageNavId, isDisplayingReportPage && canPageNavBackward);
            this.EnableDisableImage(this.NextPageNavId, isDisplayingReportPage && canPageNavForward);
            this.EnableDisableImage(this.LastPageNavId, isDisplayingReportPage && canPageNavForward);

            // Zoom
            this.EnableDisableWebControl(this.ZoomId, isDisplayingReportPage);

            // Find
            this.EnableDisableWebControl(this.FindTextBoxId, isDisplayingReportPage);
            this.EnableDisableFindButtons(isDisplayingReportPage);

            // Export
            this.EnableDisableExportButton(isDisplayingReportPage);

            // Print
            this.EnableDisableImage(this.PrintId, isDisplayingReportPage);
        }
    },

    UpdateForNewReportPage : function(updateProperties)
    {
        // Store the new property values
        this.CurrentPage = updateProperties.CurrentPage;
        this.TotalPages = updateProperties.TotalPages;
        this.IsEstimatePageCount = updateProperties.IsEstimatePageCount;
        
        // Update the current page UI
        if (this.CurrentPageId != null)
        {
            var currentPageTextBox = $get(this.CurrentPageId);
            if (currentPageTextBox != null)
                currentPageTextBox.value = this.CurrentPage;
        }
        
        // Update the total pages UI
        if (this.TotalPagesId != null)
        {
            var totalPagesLabel = $get(this.TotalPagesId);
            if (totalPagesLabel != null)
                totalPagesLabel.innerHTML = updateProperties.TotalPagesString;
        }
        
        // Assume zoom level may have changed.  Re-read it from the viewer object
        this.SetUIToCurrentZoomLevel();

        // Update the search string
        if (this.FindTextBoxId != null)
        {
            var searchTextBox = $get(this.FindTextBoxId);
            if (searchTextBox != null)
                searchTextBox.value = updateProperties.SearchText;
        }
        
        this.CanFindNext = updateProperties.CanFindNext;
        
        this.EnableDisable(true);
    },

    EnableDisableFindButtons: function(forEnable)
    {
        if (this.FindTextBoxId == null)
            return;
            
        var findBox = $get(this.FindTextBoxId);
        var findBoxHasText = findBox != null && findBox.value != null && findBox.value != "";

        this.EnableDisableTextButton(this.FindButtonId, forEnable && findBoxHasText);
        this.EnableDisableTextButton(this.FindNextButtonId, forEnable && this.CanFindNext);
    },

    EnableDisableExportButton: function(forEnable)
    {
        this.EnableDisableTextButton(this.ExportButtonId, forEnable);
    },

    EnableDisableWebControl: function(id, forEnable)
    {
        if (id == null)
            return;
            
        var element = $get(id);
        if (element != null)
            element.disabled = forEnable ? null : "disabled";
    },

    EnableDisableImage: function(id, forEnable)
    {
        if (id == null)
            return;
            
        var element = $get(id);
        if (element != null && element.control != null)
        {
            element.control.ShowImage(forEnable);
            element.disabled = forEnable ? null : "disabled";
        }
    },

    EnableDisableTextButton: function(id, forEnable)
    {
        if (id == null)
            return;
            
        var element = $get(id);
        if (element != null && element.control != null)
            element.control.SetActive(forEnable);
    },

    OnFindClick: function()
    {
        var findTextBox = $get(this.FindTextBoxId);
        var searchText = findTextBox.value;

        this.m_reportViewer.find(searchText);
    },

    OnFindNextClick: function()
    {
        this.m_reportViewer.findNext();
    },

    OnFindTextChanged: function()
    {
        if (event.propertyName == "value")
        {
            this.CanFindNext = false;
            this.EnableDisableFindButtons(true);
        }
    },

    OnFindTextFocus: function()
    {
        this.FindTextBoxPollInterval = setInterval(this.m_enableDisableFindButtonsDelegate, 250);
    },

    OnFindTextBlur: function()
    {
        clearInterval(this.FindTextBoxPollInterval);
        this.EnableDisableFindButtons(true);
    },

    OnFindTextKeyPress: function(e)
    {
        if (e.charCode == 10 || e.charCode == 13)
        {
            this.OnFindClick();
            e.preventDefault();
        }
    },

    OnCurrentPageKeyPress: function(e)
    {
        if (e.charCode == 10 || e.charCode == 13)
        {
            var currentPageTextBox = $get(this.CurrentPageId);

            var pageNumber = parseInt(currentPageTextBox.value, 10);
            if (isNaN(pageNumber) || pageNumber < 1 || (pageNumber > this.TotalPages && !this.IsEstimatePageCount))
                alert(this.InvalidPageNumberMessage);
            else
                this.OnCurrentPageClick();

            e.preventDefault();
        }
    },

    OnExportClick: function()
    {
        var formatDropDown = $get(this.ExportFormatsId);

        this.m_reportViewer.exportReport(formatDropDown.value);
        formatDropDown.selectedIndex = 0;
        formatDropDown.onchange();
    },

    OnExportFormatChanged: function()
    {
        this.EnableDisableExportButton(true);
    },

    CheckEnableDisableFindButtons: function()
    {
        this.EnableDisableFindButtons(true);
    },

    OnZoomSelectionChanged: function()
    {
        var zoomDropDown = $get(this.ZoomId);

        this.m_reportViewer.set_zoomLevel(zoomDropDown.value);
    },

    OnZoomChangedExternal: function(sender, e)
    {
        if (e.get_propertyName() != "zoomLevel" || this.ZoomId == null)
            return;
            
        this.SetUIToCurrentZoomLevel();
    },
    
    SetUIToCurrentZoomLevel : function()
    {
        if (this.ZoomId == null)
            return;
        var zoomDropDown = $get(this.ZoomId);
        if (zoomDropDown == null)
            return;

        // Get the new zoom level
        var zoomLevel = this.m_reportViewer.get_zoomLevel();
            
        var options = zoomDropDown.options;

        // Find an existing option in the dropdown that matches the new zoom level
        for (var i = 0; i < options.length; i++)
        {
            if (options(i).value == zoomLevel)
            {
                if (zoomDropDown.selectedIndex != i)
                    zoomDropDown.selectedIndex = i;
                return;
            }
        }

        // Couldn't find one so this must be a custom zoom percentage.  Add a
        // new option for it and select it.
        var newOption = document.createElement("option");
        newOption.text = escape(zoomLevel) + "%";
        newOption.value = zoomLevel;
        zoomDropDown.add(newOption);
        zoomDropDown.selectedIndex = options.length - 1;
    },


    OnPrintClick: function()
    {
        this.m_reportViewer.invokePrintDialog();
    },

    OnRefreshClick: function()
    {
        this.m_reportViewer.refreshReport();
    }
}

Microsoft.Reporting.WebFormsClient._Toolbar.registerClass("Microsoft.Reporting.WebFormsClient._Toolbar", Sys.UI.Control);
Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient.ReportViewer = function()
{
    Microsoft.Reporting.WebFormsClient.ReportViewer.initializeBase(this);

    this._internalViewerId = null;
    this._needHookEvents = true;

    this._onAppLoadDelegate = Function.createDelegate(this, this._onAppLoad);
    this._onInternalViewerDisposingDelegate = Function.createDelegate(this, this._onInternalViewerDisposing);
    this._onInternalViewerLoadingDelegate = Function.createDelegate(this, this._onInternalViewerLoading);
    this._onReportAreaContentChangedDelegate = Function.createDelegate(this, this._onReportAreaContentChanged);
    this._onReportAreaScrollPositionChangedDelegate = Function.createDelegate(this, this._onReportAreaScrollPositionChanged);
    this._onDocMapAreaCollapseChangedDelegate = Function.createDelegate(this, this._onDocMapAreaCollapseChanged);
    this._onPromptAreaCollapseChangedDelegate = Function.createDelegate(this, this._onPromptAreaCollapseChanged);
}

Microsoft.Reporting.WebFormsClient.ReportViewer.prototype =
{
    initialize: function()
    {
        Microsoft.Reporting.WebFormsClient.ReportViewer.callBaseMethod(this, "initialize");

        Sys.Application.add_load(this._onAppLoadDelegate);
    },

    dispose: function()
    {
        Microsoft.Reporting.WebFormsClient.ReportViewer.callBaseMethod(this, "dispose");

        if (this._onAppLoadDelegate != null)
        {
            Sys.Application.remove_load(this._onAppLoadDelegate);
            delete this._onAppLoadDelegate;
            this._onAppLoadDelegate = null;
        }

        if (this._onInternalViewerDisposingDelegate != null)
        {
            var internalViewer = this._tryGetInternalViewer();
            if (internalViewer != null)
            {
                internalViewer.remove_disposing(this._onInternalViewerDisposingDelegate);
                internalViewer.remove_propertyChanged(this._onReportAreaContentChangedDelegate);
                internalViewer.remove_propertyChanged(this._onInternalViewerLoadingDelegate);
                internalViewer.remove_propertyChanged(this._onReportAreaScrollPositionChangedDelegate);
                internalViewer.remove_propertyChanged(this._onDocMapAreaCollapseChangedDelegate);
                internalViewer.remove_propertyChanged(this._onPromptAreaCollapseChangedDelegate);
            }

            delete this._onInternalViewerDisposingDelegate;
            this._onInternalViewerDisposingDelegate = null;

            delete this._onReportAreaContentChangedDelegate;
            this._onReportAreaContentChangedDelegate = null;

            delete this._onInternalViewerLoadingDelegate;
            this._onInternalViewerLoadingDelegate = null;

            delete this._onReportAreaScrollPositionChangedDelegate;
            this._onReportAreaScrollPositionChangedDelegate = null;

            delete this._onDocMapAreaCollapseChangedDelegate;
            this._onDocMapAreaCollapseChangedDelegate = null;

            delete this._onPromptAreaCollapseChangedDelegate;
            this._onPromptAreaCollapseChangedDelegate = null;
        }
    },

    invokePrintDialog: function()
    {
        this._ensureReportAreaHasReportPage();

        var internalViewer = this._getInternalViewer();
        return internalViewer.PrintDialog();
    },

    exportReport: function(format)
    {
        this._ensureReportAreaHasReportPage();

        var internalViewer = this._getInternalViewer();
        return internalViewer.ExportReport(format);
    },

    find: function(text)
    {
        this._ensureReportAreaHasReportPage();

        var internalViewer = this._getInternalViewer();
        return internalViewer.Find(text);
    },

    recalculateLayout: function()
    {
        var internalViewer = this._getInternalViewer();
        // this ensures recalc will get called in IE
        internalViewer.ResizeViewerReportUsingContainingElement(true);
    },

    findNext: function()
    {
        this._ensureReportAreaHasReportPage();

        var internalViewer = this._getInternalViewer();
        return internalViewer.FindNext();
    },

    refreshReport: function()
    {
        var reportAreaContentType = this.get_reportAreaContentType();
        var canceled = !this.get_isLoading() && reportAreaContentType == Microsoft.Reporting.WebFormsClient.ReportAreaContent.None;

        // if the user successfully canceled, then there is a report loaded in this viewer,
        // so allow them to refresh it.
        if (reportAreaContentType != Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage &&
            reportAreaContentType != Microsoft.Reporting.WebFormsClient.ReportAreaContent.Error && !canceled)
        {
            this._throwExceptionForInvalidState();
        }

        var internalViewer = this._getInternalViewer();
        internalViewer.RefreshReport();
    },

    get_reportAreaContentType: function()
    {
        var internalViewer = this._getInternalViewer();
        return internalViewer.get_reportAreaContentType();
    },

    get_promptAreaCollapsed: function()
    {
        var internalViewer = this._getInternalViewer();
        return !internalViewer.ArePromptsVisible();
    },

    set_promptAreaCollapsed: function(value)
    {

        var internalViewer = this._getInternalViewer();

        var currentPromptAreaVisibility = this.get_promptAreaCollapsed();
        if (currentPromptAreaVisibility != value)
        {
            internalViewer.SetPromptAreaVisibility(!value);
            this.recalculateLayout();
        }
    },

    get_documentMapCollapsed: function()
    {
        var internalViewer = this._getInternalViewer();
        return !internalViewer.AreDocMapAreaVisible();
    },

    set_documentMapCollapsed: function(value)
    {
        var internalViewer = this._getInternalViewer();

        var currentDocMapAreaVisibility = this.get_documentMapCollapsed();
        if (currentDocMapAreaVisibility != value)
            internalViewer.SetDocMapAreaVisibility(!value);
    },

    get_zoomLevel: function()
    {
        var internalViewer = this._getInternalViewer();
        return internalViewer.get_zoomLevel();
    },

    set_zoomLevel: function(value)
    {
        var internalViewer = this._getInternalViewer();

        var currentZoomLevel = this.get_zoomLevel();
        if (currentZoomLevel != value)
        {
            internalViewer.set_zoomLevel(value);
            this.raisePropertyChanged("zoomLevel");
        }
    },

    get_reportAreaScrollPosition: function()
    {
        var internalViewer = this._getInternalViewer();
        return internalViewer.get_reportAreaScrollPosition();
    },

    set_reportAreaScrollPosition: function(scrollPoint)
    {
        if (scrollPoint == null)
            throw Error.argumentNull("scrollPoint");
        else if (!Sys.UI.Point.isInstanceOfType(scrollPoint))
            throw Error.argumentType("scrollPoint", null, Sys.UI.Point);

        var internalViewer = this._getInternalViewer();
        return internalViewer.set_reportAreaScrollPosition(scrollPoint);
    },

    get_isLoading: function()
    {
        var internalViewer = this._tryGetInternalViewer();

        if (internalViewer == null)
            return true;
        else
            return internalViewer.get_isLoading();
    },

    _get_direction: function()
    {
        // It is ok to access the internal viewer for the direction field while it is loading.
        var internalViewer = this._tryGetInternalViewer();
        if (internalViewer == null)
            throw Error.invalidOperation("Unexpected error: InternalViewer unavailable for _get_direction.");

        return internalViewer.GetDirection();
    },

    _get_toolBarUpdate : function()
    {
        var internalViewer = this._tryGetInternalViewer();
        if (internalViewer == null)
            throw Error.invalidOperation("Unexpected error: InternalViewer unavailable for _get_toolBarUpdate.");

        return internalViewer.GetToolBarUpdate();
    },

    _getInternalViewer: function()
    {
        var internalViewer = this._tryGetInternalViewer();

        if (internalViewer == null || this.get_isLoading())
            throw Error.invalidOperation("The report or page is being updated.  Please wait for the current action to complete.");

        return internalViewer;
    },

    _tryGetInternalViewer: function()
    {
        if (this._internalViewerId != null)
            return $get(this._internalViewerId).control;
        else
            return null;
    },

    _ensureReportAreaHasReportPage: function()
    {
        // This may throw if the viewer is still loading.  That's ok.  It's also
        // a requirement that the viewer not be loading when a method requires
        // that a report page be visible.
        var reportAreaContentType = this.get_reportAreaContentType();

        if (reportAreaContentType != Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage)
            this._throwExceptionForInvalidState();
    },

    _throwExceptionForInvalidState: function()
    {
        throw Error.invalidOperation("The operation cannot be performed because there is no report loaded.");
    },

    _onAppLoad: function()
    {
        // When a new internal viewer is created, hook up to events exposed by it
        if (this._needHookEvents)
        {
            var internalViewer = this._tryGetInternalViewer();
            if (internalViewer != null)
            {
                internalViewer.add_disposing(this._onInternalViewerDisposingDelegate);
                internalViewer.add_propertyChanged(this._onReportAreaContentChangedDelegate);
                internalViewer.add_propertyChanged(this._onInternalViewerLoadingDelegate);
                internalViewer.add_propertyChanged(this._onReportAreaScrollPositionChangedDelegate);
                internalViewer.add_propertyChanged(this._onDocMapAreaCollapseChangedDelegate);
                internalViewer.add_propertyChanged(this._onPromptAreaCollapseChangedDelegate);

                this._needHookEvents = false;
            }
        }
    },

    _onInternalViewerDisposing: function()
    {
        // When the internal viewer is disposed, mark that we need to hook up events to the
        // one that gets created after the postback.
        this._needHookEvents = true;
    },

    _onReportAreaContentChanged: function(sender, e)
    {
        if (e.get_propertyName() == "reportAreaContentType")
        {
            // Propagate the event to users of this class
            this.raisePropertyChanged("reportAreaContentType");
        }
    },

    _onInternalViewerLoading: function(sender, e)
    {
        if (e.get_propertyName() == "isLoading")
        {
            // Propagate the event to users of this class
            this.raisePropertyChanged("isLoading");
        }
    },

    _onReportAreaScrollPositionChanged: function(sender, e)
    {
        if (e.get_propertyName() == "reportAreaScrollPosition")
        {
            // Propagate the event to users of this class
            this.raisePropertyChanged("reportAreaScrollPosition");
        }
    },

    _onDocMapAreaCollapseChanged: function(sender, e)
    {
        if (e.get_propertyName() == "documentMapCollapsed")
        {
            // Propagate the event to users of this class
            this.raisePropertyChanged("documentMapCollapsed");
        }
    },
    
    _onPromptAreaCollapseChanged: function(sender, e)
    {
        if (e.get_propertyName() == "promptAreaCollapsed")
        {
            // Propagate the event to users of this class
            this.raisePropertyChanged("promptAreaCollapsed");
        }
    }
}

Microsoft.Reporting.WebFormsClient.ReportViewer.registerClass("Microsoft.Reporting.WebFormsClient.ReportViewer", Sys.Component);

Microsoft.Reporting.WebFormsClient.ReportAreaContent = function() { };
Microsoft.Reporting.WebFormsClient.ReportAreaContent.prototype =
{
    None: 0,
    ReportPage: 1,
    Error: 2
}
Microsoft.Reporting.WebFormsClient.ReportAreaContent.registerEnum("Microsoft.Reporting.WebFormsClient.ReportAreaContent");
﻿Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._DropDownMenu = function(element)
{
    Microsoft.Reporting.WebFormsClient._DropDownMenu.initializeBase(this, [element]);
    this.NormalStyles = null;
    this.HoverStyles = null;
    this.ButtonId = null;
    this.MenuId = null;
    this.ButtonImages = null;
    this.ArrowImages = null;
    this._Enabled = false;

    this._hideMenuDelegate = Function.createDelegate(this, this._hideMenu)
    this._keyDownDelegate = Function.createDelegate(this, this._onMenuKeyDown)

    this._button = null;
    this._buttonLink = null;
    this._menu = null;
    this._adorner = null;
    this._menuItemElements = null;
    this._selectedItem = null;
    this._ButtonImages = null;
    this._ArrowImages = null;
}

Microsoft.Reporting.WebFormsClient._DropDownMenu.prototype = {

    initialize: function()
    {
        Microsoft.Reporting.WebFormsClient._DropDownMenu.callBaseMethod(this, 'initialize');
        var element = this.get_element();
        this._button = $get(this.ButtonId);
        this._menu = $get(this.MenuId);
        $addHandlers(this._button,
            { "mouseover": this._onButtonMouseOver,
                "mouseout": this._onButtonMouseOut,
                "click": this._onButtonClick
            },
            this);
        // initialize button style
        _$RVCommon.setButtonStyle(this._button.parentNode, this._normalStyles, "default");


        // The only hyperlink in the button can accept and handles the keyboard.
        this._buttonLink = $get(this.ButtonId + "Link");
        $addHandlers(this._buttonLink, { "click": this._onButtonClick, keydown: this._onButtonKeyDown }, this);

        this._adorner = document.createElement("div");
        this._adorner.style.position = "absolute";
        this._adorner.style.zIndex = -1;
        this._adorner.style.top = "0px"
        this._adorner.style.left = "0px";
        this._adorner.style.width = "26px";
        this._adorner.style.opacity = "0.05";
        this._adorner.style.filter = 'alpha(opacity=5)';

        this._adorner.style.backgroundColor = "black";
        this._menu.appendChild(this._adorner);

        // initialize menu style
        var elements = this._menu.getElementsByTagName("a");
        this._menuItemElements = new Array();
        this._selectedItem = null;
        if (elements.length > 0)
        {
            var isRtl = this._isRTL();
            for (var index = 0; index < elements.length; index++)
            {
                $addHandlers(elements[index],
                { "mouseover": this._onMenuItemMouseOver,
                    "focus": this._onMenuItemMouseOver,
                    "click": this._onMenuItemClick
                },
                this);
                if (!isRtl)
                {
                    elements[index].style.paddingLeft = "32px";
                }
                else
                {
                    elements[index].style.paddingRight = "32px";
                }
                this._menuItemElements[this._menuItemElements.length] = elements[index];
            }
            this._selectMenuItem(this._menuItemElements[0])
        }
        Sys.UI.DomElement.setVisible(this._menu, false)
        this._ButtonImages = this._loadImages(this.ButtonImages);
        this._ArrowImages = this._loadImages(this.ArrowImages);
    },

    dispose: function()
    {
        $clearHandlers(this._button);
        $clearHandlers(this._buttonLink);
        $clearHandlers(this._menu);
        for (var index = 0; index < this._menuItemElements.length; index++)
        {
            $clearHandlers(this._menuItemElements[index]);
        }
        delete this._hideMenuDelegate;
        delete this._keyDownDelegate;

        this._button = null;
        this._buttonLink = null;
        this._menu = null;
        this._adorner = null;
        this._menuItemElements = null;
        this._selectedItem = null;
        this._ButtonImages = null;
        this._ArrowImages = null;

        Microsoft.Reporting.WebFormsClient._DropDownMenu.callBaseMethod(this, 'dispose');
    },

    set_NormalStyles: function(value) { this._normalStyles = value; },
    get_NormalStyles: function() { return this._normalStyles; },

    set_HoverStyles: function(value) { this._hoverStyles = value; },
    get_HoverStyles: function() { return this._hoverStyles; },

    _loadImages: function(imagesInfo)
    {
        var images = Sys.Serialization.JavaScriptSerializer.deserialize(imagesInfo)
        images._Enabled = document.createElement("img")
        images._Enabled.src = images.EnabledUrl;
        images._Disabled = document.createElement("img")
        images._Disabled.src = images.DisabledUrl;
        return images;
    },

    get_Enabled: function()
    {
        return this._Enabled;
    },

    set_Enabled: function(value)
    {
        if (this._ButtonImages)
        {
            if (value)
            {
                $get(this.ButtonId + "Img").src = this._ButtonImages.EnabledUrl;
                $get(this.ButtonId + "ImgDown").src = this._ArrowImages.EnabledUrl;
            }
            else
            {
                $get(this.ButtonId + "Img").src = this._ButtonImages.DisabledUrl;
                $get(this.ButtonId + "ImgDown").src = this._ArrowImages.DisabledUrl;
            }
            // property disabled of type boolean is defined in W3C DOM Level 1
            this._buttonLink.disabled = !(value == true);
            this._buttonLink.style.cursor = this._buttonLink.disabled ? "default" : "pointer";
            this._hideMenu(null);
            this._Enabled = value;
            this.raisePropertyChanged('Enabled');
        }
        else
        {
            this._Enabled = value;
        }
    },

    SetActive: function(value)
    {
        this.set_Enabled(value);
    },
    /// Open menu button handlers
    _onButtonMouseOver: function(e)
    {
        if (this._Enabled)
        {
            _$RVCommon.setButtonStyle(this._button.parentNode, this._hoverStyles, "pointer");
            e.preventDefault();
        }
    },

    _onButtonMouseOut: function(e)
    {
        if (Sys.UI.DomElement.getVisible(this._menu)) return;
        _$RVCommon.setButtonStyle(this._button.parentNode, this._normalStyles, "default");
        e.preventDefault();
    },

    _onButtonClick: function(e)
    {
        if (this._Enabled)
            this._showMenu(true);

        e.preventDefault();
    },
    _onButtonKeyDown: function(e)
    {
        if (e.keyCode == Sys.UI.Key.space)
        {
            this._onButtonClick(e);
            e.preventDefault();
        }
    },

    // Menu utility and events
    _isMenuVisible: function()
    {
        return this._menu && Sys.UI.DomElement.getVisible(this._menu)
    },

    _showMenu: function()
    {
        if (!this._isMenuVisible())
        {
            Sys.UI.DomElement.setVisible(this._menu, true);
            this._adorner.style.height = this._menu.clientHeight + "px";
            if (this._isRTL())
            {
                this._adorner.style.left = (this._menu.clientWidth - 24) + "px"
            }

            this._ensureIsOnScreen(this._menu, this._button);

            this._selectMenuItem(this._menuItemElements[0])
            $addHandler(document, "mousedown", this._hideMenuDelegate);
            $addHandler(document, "keydown", this._keyDownDelegate);
        }
    },

    _ensureIsOnScreen: function(element, anchor)
    {
        // make sure any previous value gets cleared, as
        // it's possible to exit this method not wanting to make any adjustments
        element.style.left = "";
        element.style.right = "";

        var elementDims = _$RVCommon.getBounds(element);
        var anchorDims = _$RVCommon.getBounds(anchor);

        // how far over from the left edge of the physical window is the anchor
        // in both RTL and LTR mode, this method always measures from left side of window to left edge of element    
        var anchorWindowOffsetLeft = anchor.getBoundingClientRect().left;

        if (this._isRTL())
        {
            // if the space between the left edge of the window and the anchor
            // is less than the size of the element
            if (anchorWindowOffsetLeft < elementDims.width)
            {
                // then nudge it to the right
                // style.left is ignored in RTL mode
                element.style.right = (anchorWindowOffsetLeft - elementDims.width + anchorDims.width) + "px";
            }
        }
        else // in LTR mode
        {
            var winDims = _$RVCommon.windowRect();
            var outerEdge = anchorWindowOffsetLeft + elementDims.width;

            // if the right side of this element is beyond the right side of the window
            if (outerEdge > winDims.clientWidth)
            {
                // nudge it back to the left to fix it
                element.style.left = (winDims.clientWidth - outerEdge) + "px";
            }
        }
    },

    _hideMenu: function(e)
    {
        if (this._isMenuVisible() && (e == null || e.target != this._selectedItem))
        {
            Sys.UI.DomElement.setVisible(this._menu, false);
            $removeHandler(document, "mousedown", this._hideMenuDelegate);
            $removeHandler(document, "keydown", this._keyDownDelegate);
            // takes the button in normal visual state
            _$RVCommon.setButtonStyle(this._button.parentNode, this._normalStyles, "default");
        }
    },

    _onMenuKeyDown: function(e)
    {
        var index = Array.indexOf(this._menuItemElements, this._selectedItem)
        if (index != -1)
        {
            if (e.keyCode == Sys.UI.Key.down || e.keyCode == Sys.UI.Key.left || e.keyCode == Sys.UI.Key.tab)
            {
                index = (index < this._menuItemElements.length - 1) ? index + 1 : 0;
                this._selectMenuItem(this._menuItemElements[index])
            }
            else if (e.keyCode == Sys.UI.Key.up || e.keyCode == Sys.UI.Key.right)
            {
                index = (index > 0) ? index - 1 : this._menuItemElements.length - 1;
                this._selectMenuItem(this._menuItemElements[index])
            }
            else if (e.keyCode == Sys.UI.Key.esc)
            {
                this._hideMenu();
            }
            else if (e.keyCode == Sys.UI.Key.enter)
            {
                this._menuItemElements[index].click();
            }
        }
        e.preventDefault();
    },

    // Menu item utility and avents
    _onMenuItemClick: function()
    {
        this._hideMenu(null);
    },

    _onMenuItemMouseOver: function(e)
    {
        if (e.target && e.target.tagName && e.target.tagName.toUpperCase() == "A")
        {
            this._selectMenuItem(e.target);
        }
        e.preventDefault();
    },

    _selectMenuItem: function(element)
    {
        if (this._selectedItem == element)
        {
            return;
        }
        this._selectedItem = null;
        if (element)
        {
            _$RVCommon.setButtonStyle(element.parentNode, this._hoverStyles, "pointer");
            element._selected = true;
            this._selectedItem = element;
        }
        // unselect all other menu items.
        for (var index = 0; index < this._menuItemElements.length; index++)
        {
            if (this._menuItemElements[index] != element &&
                 (this._menuItemElements[index]._selected || typeof (this._menuItemElements[index]._selected) == "undefined")
                )
            {
                _$RVCommon.setButtonStyle(this._menuItemElements[index].parentNode, this._normalStyles, "default");
                this._menuItemElements[index]._selected = false;
            }
        }
    },

    _isRTL: function()
    {
        var element = this.get_element();
        if (Microsoft.Reporting.WebFormsClient._InternalReportViewer.GetRTLDirection)
        {
            return Microsoft.Reporting.WebFormsClient._InternalReportViewer.GetRTLDirection(element) == 'rtl';
        }
        return false;
    }
}

Microsoft.Reporting.WebFormsClient._DropDownMenu.registerClass('Microsoft.Reporting.WebFormsClient._DropDownMenu', Sys.UI.Control);
﻿Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._Splitter = function(element)
{
    Microsoft.Reporting.WebFormsClient._Splitter.initializeBase(this, [element]);
    this.Vertical = true;
    this.Resizable = true;
    this.NormalStyle = null;
    this.HoverStyle = null;
    this.NormalColor = null;
    this.HoverColor = null;
    this.StorePositionField = null;
    this.StoreCollapseField = null;
    this.ImageId = null;
    this.ImageCollapse = null;
    this.ImageCollapseHover = null;
    this.ImageExpand = null;
    this.ImageExpandHover = null;
    this.Enabled = true;

    this._updating = false;
    this._image = null;
    this._StorePositionField = null;
    this._StoreCollapseField = null;
    this._onMouseMoveDelegate = null;
    this._onMouseUpDelegate = null;
    this._onSelectStartDelegate = null;
    this.IsCollapsable = true;
}

Microsoft.Reporting.WebFormsClient._Splitter.prototype = {

    initialize: function()
    {
        Microsoft.Reporting.WebFormsClient._Splitter.callBaseMethod(this, 'initialize');

        this._image = $get(this.ImageId);
        this._StorePositionField = $get(this.StorePositionField);
        this._StoreCollapseField = $get(this.StoreCollapseField);

        this._onMouseMoveDelegate = Function.createDelegate(this, this._onMouseMove);
        this._onMouseUpDelegate = Function.createDelegate(this, this._onMouseUp);
        this._onSelectStartDelegate = Function.createDelegate(this, this._onSelectStart);

        $addHandlers(this.get_element().parentNode, {
            "mouseover": this._onMouseOver,
            "focus": this._onMouseOver,
            "mouseout": this._onMouseOut,
            "mousedown": this._onMouseDown,
            "click": this._onClick
        },
                this
        );

        $addHandlers(this._image, {
            "click": this._onImageClick,
            "mouseover": this._onImageMouseOver,
            "focus": this._onImageMouseOver,
            "mouseout": this._onImageMouseOut
        },
            this
        );
    },

    dispose: function()
    {
        $clearHandlers(this.get_element().parentNode);
        $clearHandlers(this._image);

        delete this._onMouseMoveDelegate;
        delete this._onMouseUpDelegate;
        delete this._onSelectStartDelegate;

        this._image = null;
        this._StorePositionField = null;
        this._StoreCollapseField = null;

        Microsoft.Reporting.WebFormsClient._Splitter.callBaseMethod(this, 'dispose');
    },


    SetActive: function(active)
    {
        this.Enabled = active;
    },

    _setStyle: function(className, color, cursor)
    {
        var element = this.get_element();
        var elementForStyles = element.parentNode;

        elementForStyles.style.cursor = cursor;
        if (className)
        {
            elementForStyles.className = className;
        }
        else
        {
            elementForStyles.style.backgroundColor = color;
        }
    },

    _setImage: function(hovering)
    {
        var collapsed = this._getCollapsed();
        var imgsrc = null;
        if (hovering)
        {
            imgsrc = collapsed ? this.ImageExpandHover : this.ImageCollapseHover;
        }
        else
        {
            imgsrc = collapsed ? this.ImageExpand : this.ImageCollapse;
        }

        this._image.src = imgsrc;
    },

    _onImageClick: function(e)
    {
        if (this.Enabled)
            this.raiseCollapsing(!this._getCollapsed());
        e.preventDefault();
        e.stopPropagation(); // Don't let image and splitter both handle the event
    },

    _onClick: function(e)
    {
        if ((!this.Resizable || this._getCollapsed()) && this.Enabled)
            this.raiseCollapsing(!this._getCollapsed());
        e.preventDefault();
        e.stopPropagation(); // Don't let image and splitter both handle the event
    },

    _setCollapsed: function(value)
    {
        this._StoreCollapseField.value = value ? "true" : "false";
        this._setImage(false);
    },

    _getCollapsed: function()
    {
        return this._StoreCollapseField.value == "true";
    },

    _getCollapsable: function()
    {
        return this.IsCollapsable;
    },

    _setSize: function(value)
    {
        this._StorePositionField.value = value.toString();
    },

    _getSize: function()
    {
        return parseInt(this._StorePositionField.value);
    },

    _onSelectStart: function(e)
    {
        e.preventDefault();
        return false;
    },

    _onMouseOut: function(e)
    {
        this._setStyle(this.NormalStyle, this.NormalColor, "default");
        this._setImage(false);
        e.preventDefault();
        return false;
    },

    _onMouseOver: function(e)
    {
        if (this.Enabled)
        {
            if (!this.Resizable || this._getCollapsed())
            {
                this._setStyle(this.HoverStyle, this.HoverColor, "pointer");
                this._setImage(true);
            }
            else
            {
                var cursor = this.Vertical ? "w-resize" : "n-resize";
                this._setStyle(this.NormalStyle, this.NormalColor, cursor);
            }
        }
        e.preventDefault();
        e.stopPropagation();
        return false;
    },

    _onMouseDown: function(e)
    {
        if (this.Resizable)
        {
            this._lastPosition = { X: e.clientX, Y: e.clientY };
            var t = this._getMouseObjects();
            $addHandler(t.target, 'mousemove', this._onMouseMoveDelegate);
            $addHandler(t.target, 'mouseup', this._onMouseUpDelegate);
            $addHandler(t.target, 'selectstart', this._onSelectStartDelegate);
            if (t.isIE)
                t.target.setCapture();
        }
    },

    _onMouseUp: function(e)
    {
        if (this.Resizable)
        {
            var t = this._getMouseObjects();
            $removeHandler(t.target, 'mousemove', this._onMouseMoveDelegate);
            $removeHandler(t.target, 'mouseup', this._onMouseUpDelegate);
            $removeHandler(t.target, 'selectstart', this._onSelectStartDelegate);
            if (t.isIE)
                t.target.releaseCapture();
        }
    },

    _onImageMouseOver: function(e)
    {
        if (this.Enabled)
        {
            this._setStyle(this.HoverStyle, this.HoverColor, "pointer");
            this._setImage(true);
        }

        e.preventDefault();
        e.stopPropagation();
        return false;
    },

    _onImageMouseOut: function(e)
    {
        this._setStyle(this.NormalStyle, this.NormalColor, "default");
        this._setImage(false);

        e.preventDefault();
        return false;
    },

    _getMouseObjects: function()
    {
        if (!this._mouseTrackingObject)
        {
            this._mouseTrackingObject =
            {
                isIE: Sys.Browser.agent == Sys.Browser.InternetExplorer,
                target: Sys.Browser.agent == Sys.Browser.InternetExplorer ? document.body : _$RVCommon.getWindow()
            }
        }
        return this._mouseTrackingObject;
    },

    _onMouseMove: function(e)
    {
        var newPosition = { X: e.clientX, Y: e.clientY };
        if (this.Resizable && !this._getCollapsed() && this.Enabled)
        {
            var delta = 0;
            if (this.Vertical)
                delta = (newPosition.X - this._lastPosition.X) * (this._isRTL() ? -1 : 1);
            else
                delta = (newPosition.Y - this._lastPosition.Y);

            this.raiseResizing(delta);

            this._lastPosition = newPosition;
        }
    },
    _isRTL: function()
    {
        var element = this.get_element();
        if (Microsoft.Reporting.WebFormsClient._InternalReportViewer.GetRTLDirection)
        {
            return Microsoft.Reporting.WebFormsClient._InternalReportViewer.GetRTLDirection(element) == 'rtl';
        }
        return false;
    },
    add_resizing: function(handler)
    {
        this.get_events().addHandler('resizing', handler);
    },
    remove_resizing: function(handler)
    {
        this.get_events().removeHandler('resizing', handler);
    },
    raiseResizing: function(delta)
    {
        var onResizingHandler = this.get_events().getHandler('resizing');
        if (onResizingHandler)
        {
            var args = new Microsoft.Reporting.WebFormsClient._SplitterResizeEventArgs();
            args.set_delta(delta);
            onResizingHandler(this, args);
            if (args.get_size() != 0)
            {
                this._setSize(args.get_size());
            }
        }
    },
    add_collapsing: function(handler)
    {
        this.get_events().addHandler('collapsing', handler);
    },
    remove_collapsing: function(handler)
    {
        this.get_events().removeHandler('collapsing', handler);
    },
    raiseCollapsing: function(collapse)
    {
        var onCollapsingHandler = this.get_events().getHandler('collapsing');
        if (onCollapsingHandler)
        {
            var args = new Microsoft.Reporting.WebFormsClient._SplitterCollapseEventArgs();
            args.set_collapse(collapse);
            onCollapsingHandler(this, args);
            this._setCollapsed(args.get_collapse());
        }
    }
}

Microsoft.Reporting.WebFormsClient._Splitter.registerClass('Microsoft.Reporting.WebFormsClient._Splitter', Sys.UI.Control);


Microsoft.Reporting.WebFormsClient._SplitterResizeEventArgs = function () {
    Microsoft.Reporting.WebFormsClient._SplitterResizeEventArgs.initializeBase(this);
    this._delta = 0;
    this._size  = 0;
}

Microsoft.Reporting.WebFormsClient._SplitterResizeEventArgs.prototype = {
    get_delta: function()
    {
        return this._delta;
    },
    set_delta: function(value)
    {
        this._delta = value;
    },
    get_size: function()
    {
        return this._size;
    },
    set_size: function(value)
    {
        this._size = value;
    }
}
Microsoft.Reporting.WebFormsClient._SplitterResizeEventArgs.registerClass('Microsoft.Reporting.WebFormsClient._SplitterResizeEventArgs', Sys.EventArgs);

Microsoft.Reporting.WebFormsClient._SplitterCollapseEventArgs = function () {
    Microsoft.Reporting.WebFormsClient._SplitterCollapseEventArgs.initializeBase(this);
    this._collapse = false;
}

Microsoft.Reporting.WebFormsClient._SplitterCollapseEventArgs.prototype = {
    get_collapse: function()
    {
        return this._collapse;
    },
    set_collapse: function(value)
    {
        this._collapse = value;
    }
}

Microsoft.Reporting.WebFormsClient._SplitterCollapseEventArgs.registerClass('Microsoft.Reporting.WebFormsClient._SplitterCollapseEventArgs', Sys.EventArgs);﻿Type.registerNamespace('Microsoft.Reporting.WebFormsClient');

Microsoft.Reporting.WebFormsClient.ResizableControlBehavior = function(element)
{
    Microsoft.Reporting.WebFormsClient.ResizableControlBehavior.initializeBase(this, [element]);

    this.MinimumWidth = 0;
    this.MinimumHeight = 0;
    this.MaximumWidth = 100000;
    this.MaximumHeight = 100000;
    this.GripImage = null;
    this.GripImageRTL = null;
    this.Overflow = "auto";
    // Variables
    this._ctrl = null;
    this._frame = null;
    this._handle = null;
    this._tracking = false;
    this._lastClientX = 0;
    this._lastClientY = 0;
    this._leftOffset = 0;
    // Delegates
    this._onmousedownDelegate = null;
    this._onmousemoveDelegate = null;
    this._onmouseupDelegate = null;
    this._onselectstartDelegate = null;
    this._invalidateDelegate = null;
    this._tracking = false;
}

Microsoft.Reporting.WebFormsClient.ResizableControlBehavior.prototype = {
    initialize: function()
    {
        Microsoft.Reporting.WebFormsClient.ResizableControlBehavior.callBaseMethod(this, 'initialize');

        this._ctrl = this.get_element();

        this._ctrlLeft = parseInt(this._ctrl.style.left);

        // the frame will contain the control children and will be resizable
        this._frameContainer = document.createElement("span");
        this._frameContainer.style.cssText = "margin: 0px; pading: 0px; background-color: window;";
        this._frame = document.createElement('DIV');
        this._frame.style.overflow = this.Overflow;
        this._ctrl.style.overflow = 'visible';
        this._moveChildren(this._ctrl, this._frame)
        this._frameContainer.appendChild(this._frame);
        this._ctrl.appendChild(this._frameContainer);
        this._frame.style.width = this.MinimumWidth + "px";
        this._frame.style.height = this.MinimumHeight + "px";

        this._gripImageHolder = document.createElement('DIV');
        this._gripImageHolder.style.cssText = "height:16px; width: 100%; pading: 0px; margin: 0px; border-top: solid 1px lightgray; background-color: window;";
        this._frameContainer.appendChild(this._gripImageHolder);

        this._gripImage = document.createElement('IMG');
        this._gripImage.style.display = "none"
        this._gripImageHolder.appendChild(this._gripImage);

        this._onmousedownDelegate = Function.createDelegate(this, this._onmousedown);
        $addHandler(this._gripImage, 'mousedown', this._onmousedownDelegate);
        this._onmousemoveDelegate = Function.createDelegate(this, this._onmousemove);
        this._onmouseupDelegate = Function.createDelegate(this, this._onmouseup);
        this._onselectstartDelegate = Function.createDelegate(this, this._onselectstart);

        // In some browsers (ex.IE quirks mode) this._frame, as brand new item in the DOM, doesn't have offsetXXX calculated yet.
        // OffsetXXX is used in resizing function. We have to call resizeControl out of the thread once to set initial minimum size.
        this._invalidateDelegate = Function.createDelegate(this, this._reset);
        window.setTimeout(this._invalidateDelegate, 0);

    },

    _reset: function()
    {

        var windowRect = _$RVCommon.windowRect()
        var isRtl = this._isRTL(this._ctrl);
        var left = this._ctrlLeft;

        // flip the grip on if the space is less than  this.MinimumWidth
        if ((Sys.Browser.agent == Sys.Browser.InternetExplorer) && this._isRTL(_$RVCommon.getDocument()))
        {
            // IE flips the coord system.
            left = this._ctrlLeft + (windowRect.scrollWidth - windowRect.left - windowRect.width)
        }

        var noSpaceLeft = ((left - this.MinimumWidth) < windowRect.left);
        var noSpaceRight = ((left + this.MinimumWidth * 2) > windowRect.right);

        // if there is no space on both sides or there is enough space on both sides - keep the rtl settings.
        if ((noSpaceLeft && noSpaceRight) || (!noSpaceLeft && !noSpaceRight))
            this._gripImageHolder.style.direction = isRtl ? "rtl" : "ltr";
        else if (isRtl && noSpaceLeft)
            this._gripImageHolder.style.direction = "ltr";
        else if (!isRtl && noSpaceRight)
            this._gripImageHolder.style.direction = "rtl";
        else
            this._gripImageHolder.style.direction = isRtl ? "rtl" : "ltr";

        this._setRtlCues();
        this.set_Size({ width: this.MinimumWidth, height: this.MinimumHeight });

        if (this._frame.childNodes[0].focus)
            this._frame.childNodes[0].focus();
        
    },

    _setRtlCues: function()
    {
        var rtl = this._isRTL();
        // for IE
        this._gripImage.style.styleFloat = (rtl ? "left" : "right");
        // for other browsers
        this._gripImage.style.cssFloat = (rtl ? "left" : "right");
        if (_$RVCommon.isIEQuirksMode())
        {
            // IE in quirks mode due float position shifts the image with 3px.
            if (rtl)
                this._gripImage.style.marginLeft = "-3px";
            else
                this._gripImage.style.marginRight = "-3px";
        }
        this._gripImage.style.cursor = (rtl ? "ne-resize" : "se-resize")
        this._gripImage.src = (rtl ? this.GripImageRTL : this.GripImage);
        if (this._gripImage.style.display == "none")
        {
            this._gripImage.style.display = "";
        }
    },

    dispose: function()
    {
        if (this._onmousedownDelegate)
        {
            $removeHandler(this._gripImage, 'mousedown', this._onmousedownDelegate);
            delete this._onmousedownDelegate;
            this._onmousedownDelegate = null;
        }

        if (this._tracking)
        {
            this._onmouseup();
            delete this._onmousemoveDelegate;
            this._onmousemoveDelegate = null;
            delete this._onmouseupDelegate;
            this._onmouseupDelegate = null;
            delete this._onselectstartDelegate;
            this._onselectstartDelegate = null;
        }

        if (this._frame)
        {
            this._ctrl.removeChild(this._frameContainer);
            this._moveChildren(this._frame, this._ctrl)
            this._frame = null;
        }

        if (this._invalidateDelegate)
        {
            delete this._invalidateDelegate;
            this._invalidateDelegate = null;
        }

        Microsoft.Reporting.WebFormsClient.ResizableControlBehavior.callBaseMethod(this, 'dispose');
    },

    _moveChildren: function(fromElement, toElement)
    {
        while (fromElement.childNodes.length > 0)
        {
            var child = fromElement.childNodes[0];
            fromElement.removeChild(child);
            toElement.appendChild(child)
        }
    },

    _onmousedown: function(e)
    {
        this._tracking = true;
        this._lastClientX = e.clientX;
        this._lastClientY = e.clientY;
        var t = this._getMouseObjects();
        $addHandler(t.target, 'mousemove', this._onmousemoveDelegate);
        $addHandler(t.target, 'mouseup', this._onmouseupDelegate);
        $addHandler(t.target, 'selectstart', this._onselectstartDelegate);
        if (t.isIE)
            t.target.setCapture();

        e.preventDefault();
        return false;
    },

    _onmousemove: function(e)
    {
        if (this._tracking)
        {
            var deltaX = (e.clientX - this._lastClientX);
            var deltaY = (e.clientY - this._lastClientY);
            this._resizeControl(deltaX, deltaY);
            this._lastClientX = e.clientX;
            this._lastClientY = e.clientY;
        }
        e.preventDefault();
        return false;
    },

    _onmouseup: function(e)
    {
        this._tracking = false;
        this._shadowSize = null;
        var t = this._getMouseObjects();
        $removeHandler(t.target, 'mousemove', this._onmousemoveDelegate);
        $removeHandler(t.target, 'mouseup', this._onmouseupDelegate);
        $removeHandler(t.target, 'selectstart', this._onselectstartDelegate);
        if (t.isIE)
            t.target.releaseCapture();
        if (e) e.preventDefault();
        return false;
    },
    _getMouseObjects: function()
    {
        if (!this._mouseTrackingObject)
        {
            var element = this._ctrl;
            this._mouseTrackingObject =
            {
                isIE: Sys.Browser.agent == Sys.Browser.InternetExplorer,
                target: Sys.Browser.agent == Sys.Browser.InternetExplorer ? element : _$RVCommon.getWindow()
            }
        }
        return this._mouseTrackingObject;
    },
    _onselectstart: function(e)
    {
        e.preventDefault();
        return false;
    },

    _resizeControl: function(deltaX, deltaY)
    {
        if (this._frame)
        {
            if (this._isRTL())
            {
                deltaX = deltaX * -1;
            }

            if (!this._shadowSize)
            {
                this._shadowSize = this.get_Size();
            }

            // Calculate new frame width/height
            var currentSize = this._shadowSize;

            var newWidth = Math.min(Math.max(currentSize.width + deltaX, Math.max(this.MinimumWidth, 16)), this.MaximumWidth);
            var newHeight = Math.min(Math.max(currentSize.height + deltaY, Math.max(this.MinimumHeight, 16)), this.MaximumHeight);
            this._shadowSize = { width: newWidth, height: newHeight };

            var windowRect = _$RVCommon.windowRect()
            var adornerHeight = this._gripImageHolder.offsetHeight;
            // limitMaxTolerance is the number in pixels which decreases the calculated width and height, 
            // otherwise the scrollbars will appear before reaching the limit. 
            var limitMaxTolerance = Sys.Browser.agent == Sys.Browser.InternetExplorer ? 2 : 1;
            var limitWidth = windowRect.right - this._ctrl.offsetLeft - limitMaxTolerance;
            var limitHeight = windowRect.bottom - this._ctrl.offsetTop - limitMaxTolerance - adornerHeight;

            if (this._isRTL())
            {
                if (Sys.Browser.agent == Sys.Browser.InternetExplorer && this._isRTL(_$RVCommon.getDocument()))
                {
                    // IE reverse the coordinate system in RTL;
                    limitWidth = this._ctrlLeft + this.MinimumWidth + (windowRect.scrollWidth - windowRect.left - windowRect.width);
                }
                else
                {
                    limitWidth = this._ctrlLeft + this.MinimumWidth - windowRect.left;
                }
            }

            var newWidth = Math.min(newWidth, limitWidth);
            var newHeight = Math.min(newHeight, limitHeight);

            this._frame.style.width = newWidth + 'px';
            this._frame.style.height = newHeight + 'px';

            // for IE quirs mode the size of the control have to be set explicitly
            // and border have to be taken in account because IE box model.
            if (_$RVCommon.isIEQuirksMode())
            {
                var border = (parseInt(this._ctrl.style.borderWidth) || 0) * 2;
                this._ctrl.style.width = (newWidth + border) + 'px';
                this._ctrl.style.height = (newHeight + adornerHeight + border) + 'px';
            }
            else
            {
                if (Sys.Browser.agent == Sys.Browser.InternetExplorer)
                {
                    // For IE strict mode we have to set all sizes explicitly.
                    this._frameContainer.style.width = newWidth + "px";
                    this._frameContainer.style.height = newHeight + "px";
                    this._ctrl.style.width = newWidth + "px";
                    this._ctrl.style.height = (newHeight + adornerHeight) + "px";
                }
                else
                {
                    // The this._ctrl, as outer container, should be resized automatically 
                    // to its content (this._frame) if width and height is not set.
                    this._frameContainer.style.width = "";
                    this._frameContainer.style.height = "";
                    this._ctrl.style.width = "";
                    this._ctrl.style.height = "";
                }

            }
            if (this._isRTL())
            {
                this._leftOffset = -(newWidth - this.MinimumWidth);
                this._ctrl.style.left = ((isNaN(this._ctrlLeft) ? 0 : this._ctrlLeft) + this._leftOffset) + 'px'
            }
            this.raiseResizing();
        }
    },
    add_resizing: function(handler)
    {
        this.get_events().addHandler('resizing', handler);
    },
    remove_resizing: function(handler)
    {
        this.get_events().removeHandler('resizing', handler);
    },
    raiseResizing: function()
    {
        var onResizingHandler = this.get_events().getHandler('resizing');
        if (onResizingHandler)
        {
            onResizingHandler(this, Sys.EventArgs.Empty);
        }
    },
    get_Size: function()
    {
        if (this._frame)
        {
            return { width: parseInt(this._frame.style.width), height: parseInt(this._frame.style.height), fullHeight: parseInt(this._frame.style.height) + this._gripImageHolder.offsetHeight }
        }
        return { width: 0, height: 0 };
    },

    set_Size: function(value)
    {
        var size = this.get_Size();
        var deltaX = value.width - size.width;
        var deltaY = value.height - size.height;
        if (this._isRTL())
        {
            deltaX = deltaX * -1;
        }
        this._resizeControl(deltaX, deltaY);
        this.raisePropertyChanged('Size');
    },
    _isRTL: function(control)
    {
        if (!control)
        {
            control = this._gripImageHolder;
        }
        return _$RVCommon.getComputedStyle(control,"direction") != "ltr";
    }
}


Microsoft.Reporting.WebFormsClient.ResizableControlBehavior.registerClass('Microsoft.Reporting.WebFormsClient.ResizableControlBehavior', Sys.UI.Behavior);
﻿Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._AsyncWaitControl = function(element)
{
    Microsoft.Reporting.WebFormsClient._AsyncWaitControl.initializeBase(this, [element]);

    this.ReportViewerId = null;
    this.WaitControlId = null;
    this.FixedTableId = null;
    this.ClientCanceledId = null;
    this.DisplayDelay = 0;
    this.SkipTimer = false;
    this._postBackElement = null;
    this.m_triggerIds = null;

    this.m_delayTimerCompletedDelegate = Function.createDelegate(this, this._onDelayStartTimerCompleted);
    this.m_onReportViewerLoadingChangedDelegate = Function.createDelegate(this, this._onReportViewerLoadingChanged);
    this.m_onPageRequestBeginRequestDelegate = Function.createDelegate(this, this._onPageRequestBeginRequest);
    this.m_onPageRequestEndRequestDelegate = Function.createDelegate(this, this._onPageRequestEndRequest);

    this.m_visiblePollingTimer = null;

    this.m_delayTimer = null;

    this.m_waitControl = null;

    this.m_reportViewer;

    this.m_reallyCanceled = false;
    this.m_waitVisible = false;
    this.m_transVisible = false;
}

Microsoft.Reporting.WebFormsClient._AsyncWaitControl.prototype =
{
    initialize: function()
    {
        Microsoft.Reporting.WebFormsClient._AsyncWaitControl.callBaseMethod(this, "initialize");
        if (this.ReportViewerId)
        {
            this.m_reportViewer = $find(this.ReportViewerId);

            if (this.m_reportViewer != null)
            {
                this.m_reportViewer.add_propertyChanged(this.m_onReportViewerLoadingChangedDelegate);
            }

            var pageRequestManager = this._getPageRequestManager();
            if (pageRequestManager)
            {
                pageRequestManager.add_beginRequest(this.m_onPageRequestBeginRequestDelegate);
                pageRequestManager.add_endRequest(this.m_onPageRequestEndRequestDelegate);
            }

            this.m_waitControl = $get(this.WaitControlId);
        }
    },

    get_TriggerIds: function()
    {
        return this.m_triggerIds;
    },

    set_TriggerIds: function(triggerIds)
    {
        this.m_triggerIds = triggerIds;
    },

    dispose: function()
    {
        if (this.m_onReportViewerLoadingChangedDelegate)
        {
            this.m_reportViewer.remove_propertyChanged(this.m_onReportViewerLoadingChangedDelegate);
            this.m_onReportViewerLoadingChangedDelegate = null;
            delete this.m_onReportViewerLoadingChangedDelegate;
        }

        var pageRequestManager = this._getPageRequestManager();
        if (pageRequestManager)
        {
            pageRequestManager.remove_beginRequest(this.m_onPageRequestBeginRequestDelegate);
            pageRequestManager.remove_endRequest(this.m_onPageRequestEndRequestDelegate);
        }

        if (this.m_onPageRequestBeginRequestDelegate)
        {
            this.m_onPageRequestBeginRequestDelegate = null;
            delete this.m_onPageRequestBeginRequestDelegate;
        }

        this._clearPollingTimer();
        this._clearDelayTimer();

        delete this.m_delayTimerCompletedDelegate;

        Microsoft.Reporting.WebFormsClient._AsyncWaitControl.callBaseMethod(this, "dispose");
    },

    _getPageRequestManager: function()
    {
        if (Sys.WebForms && Sys.WebForms.PageRequestManager)
            return Sys.WebForms.PageRequestManager.getInstance();

        return null;
    },

    _cancelCurrentPostback: function()
    {
        // there is a tricky race condition in this code. If pageRequestManager says we are in
        // a postback, it's possible for the postback to complete before we call abortPostBack().
        // That postback will "slip through the cracks", and we won't successfully cancel it.
        // m_reallycanceled lets us know we really want the current happenings to be canceled.
        // We listen to pageRequestManager's endRequest event. If m_reallyCanceled is true,
        // but the postback wasn't aborted, then it slipped through and we force the cancellation
        // in _onPageRequestEndRequest

        this.m_reallyCanceled = true;

        var pageRequestManager = this._getPageRequestManager();
        if (pageRequestManager && pageRequestManager.get_isInAsyncPostBack())
        {
            // if we are still in a postback, then great, all we have to do is kill it.
            // The viewer will be non the wiser, and we get a nice clean cancellation.
            pageRequestManager.abortPostBack();

            if (this._triggeringControlWasForThisViewer() && this._triggeringControlWasAsyncLoadTarget())
            {
                // we do need to let the server know a cancel happened, so we'll send that up in this hidden field
                var cancelField = $get(this.ClientCanceledId);
                cancelField.value = "true";
            }
        }
        else
        {
            // Not in an async postback? then the postback has finished and the report is loading
            // its images. In this case, the viewer is busy getting the report ready, so we have to actively stop this.
            this._cancelReportViewerLoading();
        }
    },

    _cancelReportViewerLoading: function()
    {
        var internalViewer = this.m_reportViewer._tryGetInternalViewer();

        if (internalViewer == null)
            throw Error.invalidOperation("Unexpected error: InternalViewer unavailable for calling OnUserCanceled.");

        internalViewer.OnUserCanceled();
    },

    _onPageRequestBeginRequest: function(sender, e)
    {
        this._postBackElement = e.get_postBackElement();
        this.m_reallyCanceled = false;
    },

    _onPageRequestEndRequest: function(sender, e)
    {
        // if user really did cancel, but this postback is claiming
        // it was never aborted, then our race condition occured, and so
        // we need to force canceling from here
        if (!e.get_response().get_aborted() && this.m_reallyCanceled)
        {
            this._cancelReportViewerLoading();
        }
    },

    _clearDelayTimer: function()
    {
        if (this.m_delayTimer != null)
        {
            clearTimeout(this.m_delayTimer);
            this.m_delayTimer = null;
        }
    },

    _clearPollingTimer: function()
    {
        if (this.m_visiblePollingTimer != null)
        {
            clearTimeout(this.m_visiblePollingTimer);
            this.m_visiblePollingTimer = null;
        }
    },

    _triggeringControlWasAsyncLoadTarget: function()
    {
        var eventTarget = this._postBackElement;

        if (eventTarget && eventTarget.id.indexOf("Reserved_AsyncLoadTarget") >= 0)
        {
            return true;
        }

        return false;
    },

    _areRelated: function(ancestor, descendant)
    {
        // using the overload of $get to see if descendant is a descendant of ancestor
        // this is equivalent to ancestor.getElementById(descendant.id)
        // it will return null if $get fails to find descendant under ancestor
        return ancestor && descendant && (ancestor == descendant || $get(descendant.id, ancestor));
    },

    _triggeringControlWasForThisViewer: function()
    {
        var eventTarget = this._postBackElement;

        // If the postback came from something registered in our triggers list, then we are interested
        // in it and should react by doing things like showing async spinny.
        // The viewer itself is registered in this list, so it doesn't need a special case here.

        if (eventTarget)
        {
            var triggerIds = this.get_TriggerIds();
            for (var i = 0; i < triggerIds.length; ++i)
            {
                var ancestor = $get(triggerIds[i]);

                if (this._areRelated(ancestor, eventTarget))
                {
                    return true;
                }
            }
        }

        return false;
    },

    _onReportViewerLoadingChanged: function(sender, e)
    {
        if (e.get_propertyName() == "isLoading")
        {
            var isLoading = this.m_reportViewer.get_isLoading();

            if (!isLoading)
            {
                // If a viewer is about to trigger a postback, don't hide the transparency
                // Explicitly check for true to force passing in a boolean to 
                var showTrans = Microsoft.Reporting.WebFormsClient._ReportAreaAsyncLoadTarget.AsyncTriggerSelected == true;

                // hide the async wait control
                this.set_visible(showTrans, false);
                this._clearDelayTimer();
                this._clearPollingTimer();
            }
            else
            {
                // the control will tell spinny to dislay immediately if this
                // is the first time a report is being rendered
                if (this.SkipTimer)
                {
                    this.SkipTimer = false;
                    this._onDelayStartTimerCompleted();
                }
                else
                {
                    this.m_delayTimer = setTimeout(this.m_delayTimerCompletedDelegate, this.DisplayDelay);
                }
            }
        }
    },

    _onDelayStartTimerCompleted: function()
    {
        this.set_visible(true, this._triggeringControlWasForThisViewer());
    },

    set_visible: function(transVisible, waitVisible)
    {
        /// <summary>
        /// This is the "public" entry point to hiding/showing spinny.
        /// The other methods: _start_visibility_polling and _set_visible_core should not
        /// be directly called.
        ///
        /// Here we just record what the current state of spinny should be, and then
        /// kick off the polling
        /// </summary>

        this.m_transVisible = transVisible;
        this.m_waitVisible = waitVisible;

        this._start_visibility_polling();
    },


    _start_visibility_polling: function()
    {
        this._set_visible_core();

        // set a timer that will check and position spinny on a regular interval
        // this accounts for if the user resizes the window with spinny showing when
        // the layout uses percentages. A timer is necessary instead of listening to the
        // resize event because IE does not always fire the event. For simplicity, it was decided
        // to use the timer for all browsers, as using the resize event in Firefox/Safari didn't buy
        // enough to warrant the multiple code paths
        if (this.m_reportViewer.get_isLoading())
        {
            // this value influences how this action behaves
            // longer timeout = smoother overall, but spinny stays in the wrong place longer
            // shorter timeout = jerkier, but spinny stays in the wrong place shorter
            // 200 millis seemed about the best compromise between the two on a modern machine
            var timeoutMillis = 200;

            this.m_visiblePollingTimer = setTimeout(Function.createDelegate(this, this._start_visibility_polling), timeoutMillis);
        }
    },

    _set_visible_core: function()
    {
        var transVisible = this.m_transVisible;
        var waitVisible = this.m_waitVisible;

        var element = this.get_element();

        // This is to position spinny correctly in the case of the viewer placed in a non-static
        // element. See the method below for more details
        var anchoringParentOffset = this._getAnchoringParentOffsets(element);

        if (transVisible)
        {
            var dims = this._getBounds();

            element.style.top = (dims.top - anchoringParentOffset.top) + "px";
            element.style.left = (dims.left - anchoringParentOffset.left) + "px";
            element.style.width = dims.width + "px";
            element.style.height = dims.height + "px";
        }

        element.style.zIndex = 1000;
        this.m_waitControl.style.zIndex = 1001;

        Sys.UI.DomElement.setVisible(element, transVisible);
        Sys.UI.DomElement.setVisible(this.m_waitControl, waitVisible);

        if (transVisible)
        {
            this._clip(element);
        }

        if (waitVisible)
        {
            // must center spinny after making it visible, otherwise spinny has no
            // dimensions to work with

            var centering = this._getTopLeftForCenter(this.m_waitControl);
            this.m_waitControl.style.top = (centering.top - anchoringParentOffset.top) + "px";
            this.m_waitControl.style.left = (centering.left - anchoringParentOffset.left) + "px";

            this._clip(this.m_waitControl);
        }
    },

    _getAnchoringParentOffsets: function(element)
    {
        /// <summary>
        /// This method acquires the element's nearest offset parent's offsets
        /// from the window. This is used to position spinny correctly.
        /// </summary>
        ///
        /// <remarks>
        /// If the viewer is placed in an absolute, fixed or relative element,
        /// then spinny (who is position:absolute) will get its positioning
        /// anchored off of that element. The normal course of things is to determine
        /// where spinny should go relative to the window, then position it with those values
        /// but if spinny has an offset parent, it will get positioned off of that parent and not
        /// the window, causing spinny to be too far to the left and too far down. This method
        /// determines that element's offset, and we use these values to subtract spinny's ultimate
        /// position, to account for this.
        ///
        /// NOTES: this method must move up the parentNode hierarchy and not the offsetParent hierarchy
        /// because Safari and Firefox both do not consider a fixed element to be in the offset hierarchy,
        /// even though spinny will get anchored off of them
        ///
        /// We don't care about whether an ancestor has overflow or not because we are positioning off
        /// of the ancestor's upper corner, where the overflow is irrelevant. the _clip() method below
        /// will deal with overflow issues in order to clip spinny accordingly
        /// </remarks>



        var top = 0;
        var left = 0;

        if (element)
        {
            var node = element.parentNode;

            while (node && node.style != undefined && !this.HasAnchoringPositionStyle(node))
            {
                node = node.parentNode;
            }

            if (node && node.style != undefined)
            {
                var offset = _$RVCommon.documentOffset(node);
                top = offset.top;
                left = offset.left;
            }

            // Now we need to deal with the anchoring node's borders. This is handled
            // differently for the body versus any other element, and also handled differently by browser mode

            // we purposely skipped the body in the while loop above. If the anchoring element really is the body,
            // we need to handle it as a special case, instead of the standard case above. We deal with body below.
            // So if we made it all the way up to document, then really the body is what we are interested in 
            // for the remainder of the method.
            if (node == document)
            {
                node = document.body;
            }

            // NOTE: "borderTopWidth" does not work in Firefox/Safari, but "border-top-width" works in everything
            var borderTopWidth = _$RVCommon.getInt(_$RVCommon.getComputedStyle(node, "border-top-width"));
            var borderLeftWidth = _$RVCommon.getInt(_$RVCommon.getComputedStyle(node, "border-left-width"));

            if (node == document.body && !_$RVCommon.isPreIE8StandardsMode() && !_$RVCommon.isIEQuirksMode())
            {
                // IE8 standards, Firefox and Safari will cause our offsets to be off by the body's border size,
                // so we need to adjust for that. For quirks mode, this is not needed

                top -= borderTopWidth;
                left -= borderLeftWidth;
            }
            else if (node != document.body)
            {
                // for non body nodes in all browsers, we need to take their borders into account
                top += borderTopWidth;
                left += borderLeftWidth;
            }
        }

        return { top: top, left: left };
    },

    HasAnchoringPositionStyle: function(element)
    {
        // we don't want body to be considered in this method. for body, we basically want this
        // method to return false, because body is a special case in regards to margins, padding and borders
        // see above in _getAnchoringParentOffsets how we handle body.

        // Retrieve the CSS positioning style for a given node.  This method takes into account
        // positioning that is set via a style sheet in addition to inline styles.
        // The currentStyle property is supported by IE. Other browsers (Firefox, Safari) must use the
        // getComputedStyle method.
        var positionStyle = "";
        if (element.currentStyle != null)
            positionStyle = element.currentStyle.position;
        else if (window.getComputedStyle != null)
        {
            var cs = window.getComputedStyle(element, null);
            positionStyle = cs.getPropertyValue('position');
        }

        return positionStyle == "fixed" || positionStyle == "absolute" || positionStyle == "relative";
    },

    _clip: function(element)
    {
        /// <summary>
        /// Ensures the given element doesn't extend beyond a constraining parent
        /// </summary>


        // find a parent that has constrained its children's visibility with overflow
        // two parentNodes here because the first one is the updatepanel of the viewer
        var parent = $get(this.ReportViewerId).parentNode.parentNode;

        while (parent && this._hasNoOverflowSet(parent))
        {
            parent = parent.parentNode;
        }

        // if found one, set this element's clip to ensure it
        // does not go out beyond its parent
        if (parent)
        {
            var pbounds = _$RVCommon.getBounds(parent);
            var ebounds = _$RVCommon.getBounds(element);

            if (parent.scrollWidth > parent.clientWidth
                && parent.style.overflow != "hidden"
                && parent.style.overflowX != "hidden"
                && !_$RVCommon.isSafari()) // safari already accounts for scrollbars when reporting sizes
            {
                // has horizontal scrollbar
                pbounds.height -= 18;
                pbounds.bottom -= 18;
            }

            if (parent.scrollHeight > parent.clientHeight
                && parent.style.overflow != "hidden"
                && parent.style.overflowY != "hidden"
                && !_$RVCommon.isSafari())  // safari already accounts for scrollbars when reporting sizes
            {
                // has vertical scrollbar
                pbounds.width -= 18;
                pbounds.right -= 18;
            }

            var topClip = ebounds.top < pbounds.top ? pbounds.top - ebounds.top : 0;
            var leftClip = ebounds.left < pbounds.left ? pbounds.left - ebounds.left : 0;

            var bottomClip = ebounds.height - (ebounds.bottom - pbounds.bottom);
            var rightClip = ebounds.width - (ebounds.right - pbounds.right);

            // rect(top, right, bottom, left)
            // clip works non-intuitively. top and left define the upper left corner of the clipping rectangle
            // relative to the element. bottom and right define the bottom right corner, relative
            // to the element. It doesn't work like padding and margin do.
            var clip = "rect(" + topClip + "px," + rightClip + "px," + bottomClip + "px," + leftClip + "px)";
            element.style.clip = clip;
        }
    },

    _hasNoOverflowSet: function(element)
    {
        if (
        (element == null)
            ||
            (element.style == undefined)
            ||
            (
            element.style.overflow != "hidden"
            && element.style.overflow != "scroll"
            && element.style.overflow != "auto"
            && element.style.overflowX != "hidden"
            && element.style.overflowX != "scroll"
            && element.style.overflowX != "auto"
            && element.style.overflowY != "hidden"
            && element.style.overflowY != "scroll"
            && element.style.overflowY != "auto"
            )
        )
        {
            return true;
        }
        else
        {
            return false;
        }
    },

    _getTopLeftForCenter: function(element)
    {
        var dims = this._getBounds();
        var elemDims = _$RVCommon.getBounds(element);

        var top = dims.top + dims.height / 2.0 - elemDims.height / 2.0;
        var left = dims.left + dims.width / 2.0 - elemDims.width / 2.0;


        // clamp async spinny within the bounds of the viewer
        // basically we are saying nothing the viewer produces (ie spinny)
        // will invade above or just behind in the document, for below and
        // just ahead in the document, we make no promise
        var isRtl = this.m_reportViewer._get_direction() == "rtl";

        if (isRtl)
        {
            var elementRight = left + elemDims.width;
            var viewerRight = dims.left + dims.width;
            if (elementRight > viewerRight)
            {
                left -= elementRight - viewerRight;
            }
        }
        else if (left < 0)
        {
            left = 0;
        }


        if (top < 0)
        {
            top = 0;
        }

        return { top: top, left: left };
    },

    _getBounds: function()
    {
        var fixedTable = $get(this.FixedTableId);

        var offsets = _$RVCommon.documentOffset(fixedTable);
        var top = offsets.top;
        var left = offsets.left;

        var lastRow = fixedTable.rows.item(fixedTable.rows.length - 1);

        top += fixedTable.clientHeight - lastRow.offsetHeight;

        return { left: left, top: top, width: fixedTable.clientWidth, height: lastRow.offsetHeight };
    }
}

Microsoft.Reporting.WebFormsClient._AsyncWaitControl.registerClass("Microsoft.Reporting.WebFormsClient._AsyncWaitControl", Sys.UI.Control);﻿Type.registerNamespace("Microsoft.Reporting.WebFormsClient");

Microsoft.Reporting.WebFormsClient._DocMapArea = function(element)
{
    Microsoft.Reporting.WebFormsClient._DocMapArea.initializeBase(this, [element]);

    this.RootNodeId = null;
    this.SelectedNodeHiddenFieldId = null;
    this.TriggerPostBack = null;
    this.IsLTR = true;
    this.ReportViewerId = null;

    this.m_active = true;
    this.m_selectedNode = null;
    this.m_originalTextNodeColor = null;
    this.m_originalTextNodeBackColor = null;
}

Microsoft.Reporting.WebFormsClient._DocMapArea.prototype =
{
    initialize: function()
    {
        Microsoft.Reporting.WebFormsClient._DocMapArea.callBaseMethod(this, "initialize");
        
        if (this.RootNodeId != null)
        {
            this.SetDirectionForTree();
            
            var rootNode = $get(this.RootNodeId);
            var textNode = this.GetTextNodeFromTreeNode(rootNode);

            // Save the original text node color and back color
            this.m_originalTextNodeColor = textNode.style.color;
            if (this.m_originalTextNodeColor == null)
                this.m_originalTextNodeColor = "";                
            this.m_originalTextNodeBackColor = textNode.style.backgroundcolor;
            if (this.m_originalTextNodeBackColor == null)
                this.m_originalTextNodeBackColor = "";

            this.MarkNodeAsSelected(rootNode);
        }
    },

    dispose: function()
    {
        Microsoft.Reporting.WebFormsClient._DocMapArea.callBaseMethod(this, "dispose");
        this.m_selectedTextNode = null;
    },

    SetActive: function(active)
    {
        this.m_active = active;
    },

    ExpandCollapseNode : function(treeNode)
    {
        if (!this.m_active)
            return;

        var wasExpanded = this.IsNodeExpanded(treeNode);

        // Toggle visibility on the child nodes and images.  Only toggle immediate children
        var childNodes = treeNode.childNodes;
        for (var i = 0; i < childNodes.length; i++)
        {
            var childNode = childNodes[i];
            if (childNode.tagName === "DIV" ||  // Child nodes
                childNode.tagName === "INPUT")  // Expand/collapse images
            {
                this.ToggleNodeVisibility(childNode);
            }
        }
        
        // If the node is being collapsed and the currently selected node is a child
        // of that node, move the selection to the parent
        if (wasExpanded)
        {
            var allChildren = treeNode.getElementsByTagName("div");
            for (var i = 0; i < allChildren.length; i++)
            {
                if (allChildren[i] == this.m_selectedNode)
                {
                    this.MarkNodeAsSelected(treeNode);
                    break;
                }
            }
        }
    },

    IsNodeExpanded : function(treeNode)
    {
        // Look for a visible child tree node (DIV)
        var childNodes = treeNode.childNodes;
        for (var i = 0; i < childNodes.length; i++)
        {
            var childNode = childNodes[i];
            
            if (childNode.tagName === "DIV")
                return childNode.style.display !== "none";
        }
        
        // Leaf node
        return true;
    },
    
    IsLeafNode : function(treeNode)
    {
        var childNodes = treeNode.getElementsByTagName("DIV");
        return childNodes.length === 0;
    },
    
    ToggleNodeVisibility : function(node)
    {
        var isCurrentlyVisible = node.style.display !== "none";            
        _$RVCommon.SetElementVisibility(node, !isCurrentlyVisible);
    },
    
    OnTextNodeEnter : function(textNode)
    {
        if (!this.IsTextNodeSelected(textNode))
        {
            textNode.style.color = "highlighttext";
            textNode.style.backgroundColor = "highlight";
        }
    },
    
    OnTextNodeLeave : function(textNode)
    {
        if (!this.IsTextNodeSelected(textNode))
        {
            textNode.style.color = this.m_originalTextNodeColor;
            textNode.style.backgroundColor = this.m_originalTextNodeBackColor;
        }
    },
    
    IsTextNodeSelected : function(textNode)
    {
        return this.m_selectedNode != null && textNode == this.GetTextNodeFromTreeNode(this.m_selectedNode);
    },
    
    OnAnchorNodeSelected : function(anchorNode)
    {
        this.OnTreeNodeSelected(anchorNode.parentNode);
    },
    
    OnTreeNodeSelected : function(treeNode)
    {
        var docMapId = treeNode.attributes.getNamedItem("DocMapId").value;
        this.MarkNodeAsSelected(treeNode);
        $get(this.SelectedNodeHiddenFieldId).value = docMapId;
        this.TriggerPostBack();
    },
    
    MarkNodeAsSelected : function(treeNode)
    {
        // Remove old selection
        if (this.m_selectedNode != null)
        {
            var selectedTextNode = this.GetTextNodeFromTreeNode(this.m_selectedNode);

            selectedTextNode.style.color = this.m_originalTextNodeColor;
            selectedTextNode.style.backgroundColor = this.m_originalTextNodeBackColor;

            this.m_selectedNode = null;
        }
        
        if (treeNode != null)
        {
            this.m_selectedNode = treeNode;
            
            var selectedTextNode = this.GetTextNodeFromTreeNode(treeNode);
            
            selectedTextNode.style.color = "highlighttext";
            selectedTextNode.style.backgroundColor = "highlight";
            
            try
            {
                selectedTextNode.focus();
                
                // Update scroll position.  Ensure the tree node is visible
                var scrollableDiv = treeNode.offsetParent;
                if (scrollableDiv.scrollTop > selectedTextNode.offsetTop)
                    scrollableDiv.scrollTop = selectedTextNode.offsetTop - 1; // -1 for just a little padding
                else if (scrollableDiv.scrollTop + scrollableDiv.offsetHeight < selectedTextNode.offsetTop + selectedTextNode.offsetHeight)
                    scrollableDiv.scrollTop = selectedTextNode.offsetTop + selectedTextNode.offsetHeight - scrollableDiv.offsetHeight + 1; // +1 for just a little padding
            }
            catch (e)
            {
                // focus will throw if the item can't get the focus (e.g. the node is hidden).
                // Since we are only setting focus to be consistent with the selection, this is
                // ok - if the user can't see the focus rectangle, it won't be inconsistent
            }
        }
    },
    
    GetTextNodeFromTreeNode : function(treeNode)
    {
        var anchorNode = treeNode.getElementsByTagName("a")[0];
        return anchorNode.getElementsByTagName("span")[0];
    },
    
    SetDirectionForTree : function()
    {
        // If the server rendered the incorrect direction, fix it.
        var reportViewer = $find(this.ReportViewerId);
        var direction = reportViewer._get_direction();
        if ((direction === "ltr" && !this.IsLTR) || (direction === "rtl" && this.IsLTR))
        {
            var docMapArea = this.get_element();

            // Swap the margins for each child tree node
            var childNodes = docMapArea.getElementsByTagName("DIV");
            for (var i = 0; i < childNodes.length; i++)
            {
                var treeNode = childNodes[i];
                
                var oldMarginRight = treeNode.style.marginRight;
                treeNode.style.marginRight = treeNode.style.marginLeft;
                treeNode.style.marginLeft = oldMarginRight;
            }

            this.IsLTR = !this.IsLTR;
        }
    },
    
    OnKeyDown : function(e)
    {
        if (!this.m_active)
            return;

        if (e.altKey == true)
            return;

        switch (e.keyCode)
        {
            case 187: //=
                if (!e.shiftKey)
                    break;

            case 107: //+
                if (!this.IsLeafNode(this.m_selectedNode) && !this.IsNodeExpanded(this.m_selectedNode))
                    this.ExpandCollapseNode(this.m_selectedNode);
                e.returnValue = false;
                break;

            case 189: //-
                if (e.shiftKey)
                    break;

            case 109: //-
                if (!this.IsLeafNode(this.m_selectedNode) && this.IsNodeExpanded(this.m_selectedNode))
                    this.ExpandCollapseNode(this.m_selectedNode);
                e.returnValue = false;
                break;

            case Sys.UI.Key.right:
                e.returnValue = false;
                if (!this.IsLeafNode(this.m_selectedNode))
                {
                    if (!this.IsNodeExpanded(this.m_selectedNode))
                        this.ExpandCollapseNode(this.m_selectedNode);
                    else
                    {
                        // Select the first child
                        var firstChild = this.m_selectedNode.getElementsByTagName("DIV")[0];
                        this.MarkNodeAsSelected(firstChild);
                    }
                }
                break;

            case Sys.UI.Key.down:
                // Find visible child
                if (!this.IsLeafNode(this.m_selectedNode) && this.IsNodeExpanded(this.m_selectedNode))
                {
                    var firstChild = this.m_selectedNode.getElementsByTagName("DIV")[0];
                    this.MarkNodeAsSelected(firstChild);
                }
                else
                {
                    // Find next sibling.  If no sibling, go up a level and look for a sibling there
                    var parent = this.m_selectedNode;
                    var rootNode = $get(this.RootNodeId);
                    while (parent != rootNode)
                    {
                        // Advance up the hierarchy
                        var nodeToFindNextSiblingOf = parent;
                        parent = parent.parentNode;

                        // Find the index of the current selected node                        
                        var children = parent.childNodes;
                        for (var i = 0; i < children.length; i++)
                        {
                            if (children[i] == nodeToFindNextSiblingOf)
                                break;
                        }

                        // Select the next sibling if this is not the last node                        
                        if (i + 1 < children.length)
                        {
                            this.MarkNodeAsSelected(children[i + 1]);
                            break;
                        }
                    }
                }
                e.returnValue = false;
                break;

            case Sys.UI.Key.left:
                if (this.IsLeafNode(this.m_selectedNode) || !this.IsNodeExpanded(this.m_selectedNode))
                {
                    // Move to parent node
                    if (this.m_selectedNode != $get(this.RootNodeId))
                        this.MarkNodeAsSelected(this.m_selectedNode.parentNode);
                }
                else
                {
                    // An expanded node - collapse it
                    this.ExpandCollapseNode(this.m_selectedNode);
                }
                e.returnValue = false;
                break;

            case Sys.UI.Key.up:
                if (this.m_selectedNode != $get(this.RootNodeId))
                {
                    var siblings = this.m_selectedNode.parentNode.childNodes;
                    
                    // Find the index of the current selected node                        
                    for (var i = 0; i < siblings.length; i++)
                    {
                        if (siblings[i] == this.m_selectedNode)
                            break;
                    }

                    // Find the immediately previous sibling to the selected node
                    if (i > 0 && siblings[i - 1].tagName === "DIV")
                    {
                        var previousSibling = siblings[i - 1];
                        
                        // If the previous sibling is expanded, find its last expanded child
                        var trav = previousSibling;
                        while (trav != null && !this.IsLeafNode(trav) && this.IsNodeExpanded(trav))
                        {
                            var travChildren = trav.childNodes;
                            for (var i = travChildren.length - 1; i >= 0; i--)
                            {
                                if (travChildren[i].tagName === "DIV")
                                {
                                    trav = travChildren[i];
                                    break;
                                }
                            }
                        }
                        
                        this.MarkNodeAsSelected(trav);
                    }
                    else
                        this.MarkNodeAsSelected(this.m_selectedNode.parentNode);
                }
                e.returnValue = false;
                break;

            case Sys.UI.Key.enter:
                this.OnTreeNodeSelected(this.m_selectedNode);
                e.returnValue = false;
                break;
        }
    }
}

Microsoft.Reporting.WebFormsClient._DocMapArea.registerClass("Microsoft.Reporting.WebFormsClient._DocMapArea", Sys.UI.Control);function Microsoft_ReportingServices_HTMLRenderer_CalculateZoom(reportCellId)
{
    //Calculates zoom based on reportCellId zoom.  By default, it's 1 (or 100%)
    var zoom = 1;
    if (reportCellId)
    {
        var reportCell = document.getElementById(reportCellId);
        if (reportCell)
        {
            var zt = reportCell.style.zoom;
            if (zt && zt.substring(zt.length - 1) == '%')
            {
                zoom = zt.substring(0, zt.length - 1) / 100;
            }
            else
            {
                zoom = zt;
            }
            if (!zoom || zoom == 0) zoom = 1;
        }
    }
    return zoom;
}

function Microsoft_ReportingServices_HTMLRenderer_CalculateOffset(topElement, targetElement)
{
    //Calculates the top and left offset based on the topElement and targetElement
    var measureElement = targetElement;
    var divTop = 0;
    var divLeft = 0;
    while (measureElement && (!topElement || measureElement.id != topElement.id))
    {
        divTop += measureElement.offsetTop;
        divLeft += measureElement.offsetLeft;
        var offsetParent = measureElement.offsetParent;
        while (measureElement != offsetParent && (!topElement || measureElement.id != topElement.id))
        {
            measureElement = measureElement.parentNode;
        }
    }

    return { top: divTop, left: divLeft };
}

function Microsoft_ReportingServices_HTMLRenderer_IsStandardsMode()
{
    return document.compatMode && document.compatMode != "BackCompat";
}

function Microsoft_ReportingServices_HTMLRenderer_IsIE()
{
    if (document.all)
        return true;
    return false;
}

function Microsoft_ReportingServices_HTMLRenderer_IsIE8OrLater()
{
    if (Microsoft_ReportingServices_HTMLRenderer_IsIE() && document.documentMode && document.documentMode >= 8)
        return true;
    return false;
}

function Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(size)
{
    var sizeString = size.toString();
    // Get the numeric value of the size measurement.
    // First set sizeValue to the sizeString. (assuming no units or length of size
    // < 2).

    var sizeValue = parseFloat(sizeString);

    if (isNaN(sizeValue))
    {
        sizeValue = 0;
    }

    // Now try to parse out the sizeValue and the sizeUnit
    if ((sizeString.length >= 2) && (sizeValue > 0))
    {
        sizeValue = parseFloat(sizeString.substring(0, sizeString.length - 2));
        // Get the unit type of the size measurement.
        var sizeUnit = sizeString.substring(sizeString.length - 2, sizeString.length);

        var dpi = Microsoft_ReportingServices_HTMLRenderer_PxPerInch();

        switch (sizeUnit)
        {
            case "mm":
                sizeValue = sizeValue * dpi / 25.4;
                break;
            case "pt":
                sizeValue = sizeValue * dpi / 72;
                break;
            case "in":
                sizeValue = sizeValue * dpi;
                break;
            case "cm":
                sizeValue = sizeValue * dpi / 2.54;
                break;
            case "px":
                sizeValue = sizeValue;
                break;
            default:
                // No units specified, just use the sizeString.
                sizeValue = parseFloat(sizeString);
                break;
        }
    }
    return sizeValue;
}

function Microsoft_ReportingServices_HTMLRenderer_PxPerInch()
{
    var div = document.createElement("div");
    div.id = "fakeDPIDiv";
    div.style.cssText = "width:72pt; height:0pt; display:hidden; position:absolute; z-index:-1; font-size: 0pt; top:0px; left:0px";
    document.body.appendChild(div);
    var width = div.style.pixelWidth;
    if (!width)
    {
        width = div.offsetWidth;
    }
    document.body.removeChild(div);
    dpi = width;
    return dpi;
}

function Microsoft_ReportingServices_HTMLRenderer_GetStyle(element, styleProp)
{
    var retVal = null;

    if (element.currentStyle)
    {
        retVal = element.currentStyle[styleProp];
    }
    else
    {
        var computedStyle = window.getComputedStyle(element, null);
        retVal = computedStyle[styleProp];
    }

    return retVal;
}

function Microsoft_ReportingServices_HTMLRenderer_GetFirstChildElementNode(element)
{
    var firstChildNode = null;
    var childElements = element.childNodes;
    for (var i = 0; i < childElements.length; i++)
    {
        var child = childElements[i];
        if (child.nodeType == 1)
        {
            // nodeType = 1 denotes an element node.
            firstChildNode = child;
            break;
        }
    }
    return firstChildNode;
}

function Microsoft_ReportingServices_HTMLRenderer_SubtractHorizontalBorders(element, width)
{
    var borderLeftWidth = Microsoft_ReportingServices_HTMLRenderer_GetStyle(element, "borderLeftWidth");

    if (borderLeftWidth)
    {
        width = width - Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(borderLeftWidth);
    }

    var borderRightWidth = Microsoft_ReportingServices_HTMLRenderer_GetStyle(element, "borderRightWidth");

    if (borderRightWidth)
    {
        width = width - Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(borderRightWidth);
    }

    return width;
}

function Microsoft_ReportingServices_HTMLRenderer_SubtractHorizontalPaddings(element, width)
{
    var paddingLeft = Microsoft_ReportingServices_HTMLRenderer_GetStyle(element, "paddingLeft");

    if (paddingLeft)
    {
        width = width - Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(paddingLeft);
    }

    var paddingRight = Microsoft_ReportingServices_HTMLRenderer_GetStyle(element, "paddingRight");

    if (paddingRight)
    {
        width = width - Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(paddingRight);
    }

    return width;
}

function Microsoft_ReportingServices_HTMLRenderer_SubtractHorizontalBordersPaddings(element)
{
    // This function should currently only be called in FitProportional.js when the following below
    // condition is true: Microsoft_ReportingServices_HTMLRenderer_IsStandardsMode() && Microsoft_ReportingServices_HTMLRenderer_IsIE()
    var width = Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(element.currentStyle.width);

    width = Microsoft_ReportingServices_HTMLRenderer_SubtractHorizontalBorders(element, width);

    width = Microsoft_ReportingServices_HTMLRenderer_SubtractHorizontalPaddings(element, width);

    if (width <= 0)
    {
        // Don't allow a negative sizing to be returned.
        width = 1;
    }

    return width.toString() + "px";
}

function Microsoft_ReportingServices_HTMLRenderer_SubtractVerticalBorders(element, height)
{
    var borderTopWidth = Microsoft_ReportingServices_HTMLRenderer_GetStyle(element, "borderTopWidth");

    if (borderTopWidth)
    {
        height = height - Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(borderTopWidth);
    }

    var borderBottomWidth = Microsoft_ReportingServices_HTMLRenderer_GetStyle(element, "borderBottomWidth");

    if (borderBottomWidth)
    {
        height = height - Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(borderBottomWidth);
    }

    return height;
}

function Microsoft_ReportingServices_HTMLRenderer_SubtractVerticalPaddings(element, height)
{
    var paddingTop = Microsoft_ReportingServices_HTMLRenderer_GetStyle(element, "paddingTop");

    if (paddingTop)
    {
        height = height - Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(paddingTop);
    }

    var paddingBottom = Microsoft_ReportingServices_HTMLRenderer_GetStyle(element, "paddingBottom");

    if (paddingBottom)
    {
        height = height - Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(paddingBottom);
    }

    return height;
}

function Microsoft_ReportingServices_HTMLRenderer_SubtractVerticalBordersPaddings(element)
{
    // This function should currently only be called in FitProportional.js when the following below
    // condition is true: Microsoft_ReportingServices_HTMLRenderer_IsStandardsMode() && Microsoft_ReportingServices_HTMLRenderer_IsIE()
    var height = Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(element.currentStyle.height);

    height = Microsoft_ReportingServices_HTMLRenderer_SubtractVerticalBorders(element, height);

    height = Microsoft_ReportingServices_HTMLRenderer_SubtractVerticalPaddings(element, height);

    if (height <= 0)
    {
        // Don't allow a negative sizing to be returned.
        height = 1;
    }

    return height.toString() + "px";
}

function Microsoft_ReportingServices_HTMLRenderer_GetMaxChildRowSpan(row)
{
    var maxRowSpan = 1;
    var i = 0;

    // Bug only occurs (setting heights of <tr> elements in IE8 standards mode).
    if (Microsoft_ReportingServices_HTMLRenderer_IsIE8OrLater() &&
        Microsoft_ReportingServices_HTMLRenderer_IsStandardsMode())
    {
        // This function should only apply its logic when row is a <TR> element.
        if (row.nodeName == "TR")
        {
            if (row.childNodes)
            {
                for (i = 0; i < row.childNodes.length; i++)
                {
                    var rowChildNode = row.childNodes[i];
                    var rowSpan = rowChildNode.getAttribute("rowSpan");
                    if (rowSpan)
                    {
                        rowSpan = parseInt(rowSpan);
                        if (rowSpan > maxRowSpan)
                        {
                            maxRowSpan = rowSpan;
                        }
                    }
                }
            }
        }
    }
    return maxRowSpan;
}

function Microsoft_ReportingServices_HTMLRenderer_GrowRectangles(reportDivID)
{
    // This function is used to grow rectangles to fit its contents which could potentially get clipped
    // (in IE quirks + IE7 standards mode) when growth (due to text-wrapping, etc...) occurs.
    if (Microsoft_ReportingServices_HTMLRenderer_IsIE())
    {
        var reportDiv = document.firstChild;
        if (reportDivID)
        {
            reportDiv = document.getElementById(reportDivID);
        }
        else
        {
            reportDiv = document.firstChild;
        }

        // The oReportDiv consists of only the first page of content.
        var reportDivParent = reportDiv.parentNode;
        var reportDivParentDivs = reportDivParent.getElementsByTagName("DIV");
        // Need to grow childNode rectangles in DOM before parentNode rectangles.
        for (var i = reportDivParentDivs.length - 1; i >= 0; i--)
        {
            var div = reportDivParentDivs[i];
            if (div.getAttribute("growRect"))
            {
                if (!Microsoft_ReportingServices_HTMLRenderer_IsStandardsMode())
                {
                    // In IE quirks mode, if the contents of the rectangle outgrows the rectangle,
                    // no clipping occurs, and the clientWidth of the rectangle DIV is the same
                    // as its child contents, but no horizontal scrollbars appear even though the contents
                    // overflow the screen. To get the scrollbar to appear as desired, set the style width
                    // of the rectangle DIV to be its client dimensions (esp. width) in pixels.
                    if (div.clientWidth > 0)
                    {
                        div.style.width = div.clientWidth + "px";
                    }

                    if (div.clientHeight > 0)
                    {
                        div.style.height = div.clientHeight + "px";
                    }
                }

                // In IE7 standards mode, a tablix (or any other report item)
                // that outgrows its rectangular container will have its contents clipped.
                var childNode = div.firstChild;

                while ((childNode != null) && (childNode.tagName == "DIV") && (childNode.getAttribute("growRect")))
                {
                    childNode = childNode.firstChild;
                }

                if (childNode != null)
                {
                    if (childNode.clientWidth > div.clientWidth)
                    {
                        div.style.width = childNode.clientWidth + "px";
                    }

                    if (childNode.clientHeight > div.clientHeight)
                    {
                        div.style.height = childNode.clientHeight + "px";
                    }
                }
            }
        }
    }
}

function Microsoft_ReportingServices_HTMLRenderer_FitVertText(reportDivID)
{
    var reportDiv = document.firstChild;
    if (reportDivID)
    {
        reportDiv = document.getElementById(reportDivID);
    }
    else
    {
        reportDiv = document.firstChild;
    }

    // The oReportDiv consists of only the first page of content.
    var reportDivParent = reportDiv.parentNode;
    var reportDivParentDivs = reportDivParent.getElementsByTagName("DIV");
    for (var i = 0; i < reportDivParentDivs.length; i++)
    {
        var div = reportDivParentDivs[i];
        if (div.getAttribute("fitverttext"))
        {
            if (div.clientWidth < div.firstChild.clientWidth)
            {
                div.style.width = div.firstChild.clientWidth + "px";
            }

            if (div.clientHeight < div.firstChild.clientHeight)
            {
                div.style.height = div.firstChild.clientHeight + "px";
            }

            if (div.clientWidth > div.parentNode.clientWidth)
            {
                // If a lot of breaking vertical characters causes vertical text
                // the vertical textbox inside of tablix to render outside its tablix
                // cell, set the textbox's client dimensions to the tablix cell dimensions
                // and change display to block.
                div.style.width = div.parentNode.clientWidth + "px";
                div.style.height = div.parentNode.clientHeight + "px";
                div.style.display = "block";
            }
        }
    }
}

//FitProportional
Microsoft_ReportingServices_HTMLRenderer_FitProportional = function()
{
}
Microsoft_ReportingServices_HTMLRenderer_FitProportional.prototype =
{
    ResizeImage: function(o, reportDivId, reportCellId)
    {

        if (!o) return; var op = o.parentNode; if (!op) return;
        var width = o.width;
        var height = o.height;
        var target = o;
        var parentDiv = op;
        var isIE7OrLess = false;
        if (op.tagName == 'A') //If the parent is an A-tag, get the div containing
        {
            op = op.parentNode;
            parentDiv = op;
        }

        var stdMode = Microsoft_ReportingServices_HTMLRenderer_IsStandardsMode();
        var isIE7OrLess = false;
        if (stdMode)
        {
            if (Microsoft_ReportingServices_HTMLRenderer_IsIE() &&
            !Microsoft_ReportingServices_HTMLRenderer_IsIE8OrLater())
            {
                isIE7OrLess = true;
            }
        }

        if (stdMode && Microsoft_ReportingServices_HTMLRenderer_IsIE())
        {
            if (parentDiv.getAttribute("alreadyResized") == null)
            {
                if (parentDiv.currentStyle.minWidth)
                {
                    if (parentDiv.clientWidth > Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(parentDiv.currentStyle.minWidth) + 1)
                    {
                        var adjustedMinWidth = Microsoft_ReportingServices_HTMLRenderer_SubtractHorizontalBordersPaddings(parentDiv);
                        parentDiv.style.minWidth = adjustedMinWidth;

                    }
                }

                if (isIE7OrLess)
                {
                    if (parentDiv.currentStyle.width)
                    {
                        if (parentDiv.clientWidth > Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(parentDiv.currentStyle.width) + 1)
                        {
                            var adjustedWidth = Microsoft_ReportingServices_HTMLRenderer_SubtractHorizontalBordersPaddings(parentDiv);
                            parentDiv.style.width = adjustedWidth;

                        }
                    }

                    if (parentDiv.currentStyle.height)
                    {
                        if (parentDiv.clientHeight > Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(parentDiv.currentStyle.height) + 1)
                        {
                            var adjustedHeight = Microsoft_ReportingServices_HTMLRenderer_SubtractVerticalBordersPaddings(parentDiv);
                            parentDiv.style.height = adjustedHeight;

                        }
                    }
                }
                parentDiv.setAttribute("alreadyResized", "true");
            }
        }

        var scaleOffset = 1; //Matching previous behavior
        var useConsolidation = false;
        var repositionTopLeft = false;
        var zoom = 1;
        var resizeWithZoom = false;
        if (op.tagName == 'DIV' && op.getAttribute("imgConFitProp")) //ImageConsolidation, FitProportional
        {
            target = op;

            height = parseInt(op.style.height);
            width = parseInt(op.style.width);

            op = op.parentNode;

            scaleOffset = 0;
            useConsolidation = true;

            if (stdMode &&
                Microsoft_ReportingServices_HTMLRenderer_IsIE() &&
                isIE7OrLess)
            {
                if (target.style.position != "absolute")
                {
                    target.style.position = "absolute";
                }

                zoom = Microsoft_ReportingServices_HTMLRenderer_CalculateZoom(reportCellId);

                if (op.getAttribute("origHeight"))
                    height = op.getAttribute("origHeight");
                else
                    op.setAttribute("origHeight", height);

                if (op.getAttribute("origWidth"))
                    width = op.getAttribute("origWidth");
                else
                    op.setAttribute("origWidth", width);

                resizeWithZoom = true;
            }
        }

        if ((o.width != 0) && (o.height != 0) && op)
        {
            var oHeight = o.height;
            var oWidth = o.width;

            if (o.naturalHeight) //Always use the actual image sizing information, if available
            {
                oHeight = o.naturalHeight;
                oWidth = o.naturalWidth;
                if (!useConsolidation)
                {
                    height = oHeight;
                    width = oWidth;
                }
            }
            else if (o.width == 1 && o.height == 1 && !useConsolidation)
            {
                //Calculate the base image size by creating another and retrieving the sizing
                //Not Supported in IE6
                var tmpImage = new Image();
                tmpImage.src = o.src;
                oHeight = tmpImage.height;
                oWidth = tmpImage.width;
                height = oHeight;
                width = oWidth;
            }

            if (resizeWithZoom)
            {
                if (o.getAttribute("origHeight"))
                    oHeight = o.getAttribute("origHeight");
                else
                    o.setAttribute("origHeight", oHeight);

                if (o.getAttribute("origWidth"))
                    oWidth = o.getAttribute("origWidth");
                else
                    o.setAttribute("origWidth", oWidth);
            }

            var opHeight = op.clientHeight;
            var opWidth = op.clientWidth;
            //If parent size is larger than the item containing the FitProportional Image, use the larger size
            if (o.clientHeight == op.clientHeight && op.parentNode && op.parentNode.clientHeight >= o.clientHeight)
            {
                opHeight = op.parentNode.clientHeight;
                if (op.parentNode.nodeName == 'TD' && op.parentNode.parentNode.clientHeight > opHeight)
                    opHeight = op.parentNode.parentNode.clientHeight;
                opWidth = op.parentNode.clientWidth;
            }
            var dy = (opHeight + scaleOffset - o.pv) / height;
            var dx = (opWidth + scaleOffset - o.ph) / width;
            var dz = Math.min(dx, dy);
            var targetHeight = oHeight * dz * zoom;
            var targetWidth = oWidth * dz * zoom;
            if (useConsolidation)
            {
                if (targetHeight > 0)
                    o.height = targetHeight;

                if (width && targetWidth > 0)
                    o.width = targetWidth;

                if (height > 0 && dz > 0)
                    parentDiv.style.height = (height * dz * zoom) + "px";

                if (width > 0 && dz > 0)
                    parentDiv.style.width = (width * dz * zoom) + "px";

                //Offset based on the original value
                var origLeft = parseInt(o.style.left);
                var origTop = parseInt(o.style.top);

                var parentTop = 0;
                var parentLeft = 0;

                if (resizeWithZoom)
                {
                    //IE7 cannot use the relative coordinates, so the parentDiv is positioned
                    var reportDiv = document.getElementById(reportDivId);
                    var offsets = Microsoft_ReportingServices_HTMLRenderer_CalculateOffset(reportDiv, op);
                    parentLeft = offsets.left;
                    parentTop = offsets.top;

                    if (o.getAttribute("origTop"))
                        origTop = parseInt(o.getAttribute("origTop"))
                    else
                        o.setAttribute("origTop", parseInt(o.style.top));
                    if (o.getAttribute("origLeft"))
                        origLeft = parseInt(o.getAttribute("origLeft"));
                    else
                        o.setAttribute("origLeft", parseInt(o.style.left));

                    o.style.top = (origTop * zoom) + "px";
                    o.style.left = (origLeft * zoom) + "px";
                }

                if (!isIE7OrLess)
                {
                    // Absolute positioning in IE8 standards mode/firefox puts items not relative to
                    // their container. Need to set parentDiv position style back to relative.
                    parentDiv.style.position = "relative";
                }

                var oCurrentLeft = parseInt(o.style.left);
                var oCurrentTop = parseInt(o.style.top);
                if (oCurrentLeft != null)
                {
                    o.style.left = parseInt(oCurrentLeft * dz) + "px";
                }
                if (oCurrentTop != null)
                {
                    o.style.top = parseInt(oCurrentTop * dz) + "px";
                }
                parentDiv.style.left = (parentLeft * zoom) + "px";
                parentDiv.style.top = (parentTop * zoom) + "px";
            }
            else
            {
                //Use the calculated size if it doesn't cause the parent to grow
                if (targetHeight > opHeight)
                    targetHeight = opHeight;
                if (targetWidth > opWidth)
                    targetWidth = opWidth;

                o.height = targetHeight;
                if (width) o.width = targetWidth;
            }
        }
    },
    ResizeImages: function(reportDivId, reportCellId)
    {
        var reportDiv = document.getElementById(reportDivId);
        if (reportDiv)
        {
            var images = reportDiv.getElementsByTagName("IMG");
            for (var i = 0; i < images.length; i++)
            {
                var o = images[i];
                if (o.fitproportional && o.complete && !o.errored)
                    this.ResizeImage(o, reportDivId, reportCellId);
            }
        }
    },
    PollResizeImages: function(reportDivId, reportCellId)
    {
        var reportDiv = document.getElementById(reportDivId);
        if (reportDiv)
        {
            var images = reportDiv.getElementsByTagName("IMG");
            for (var i = 0; i < images.length; i++)
            {
                var o = images[i];
                if (!o.complete && !o.errored)
                {
                    setTimeout('this.PollResizeImages(' + escape(reportDivId) + ',' + escape(reportDivId) + ')', 250);
                    return;
                }
            }
            this.ResizeImages(reportDivId);
        }
    }
}
Microsoft_ReportingServices_HTMLRenderer_FixedHeader = function(ReportDivId, ReportCellId, ContainerId, IDPrefix)
{
    this.ReportCellId = ReportCellId;
    this.ReportDivId = ReportDivId;
    this.ContainerId = ContainerId;
    if (!IDPrefix)
        IDPrefix = "";
    this.IDPrefix = IDPrefix;
}
Microsoft_ReportingServices_HTMLRenderer_FixedHeader.prototype =
{
    CreateFixedRowHeader: function(arr, id)
    {
        var tableID = arr[0];
        if (document.getElementById(this.IDPrefix + id))
            return;
        var tNode = document.getElementById(this.IDPrefix + tableID);
        if (tNode == null)
            return;
        tNode = tNode.cloneNode(false);
        tNode.removeAttribute('id');
        var tBodyNode = document.createElement("TBODY");
        var currentRow = document.getElementById(this.IDPrefix + arr[1]);
        currentRow = currentRow.cloneNode(false);
        currentRow.removeAttribute('id');
        for (var x = 2; x < arr.length; x++)
        {
            var nextElement = document.getElementById(this.IDPrefix + arr[x]);
            if (nextElement.tagName.toUpperCase() == "TR")
            {
                nextElement = nextElement.cloneNode(false);
                nextElement.removeAttribute('id');
                tBodyNode.appendChild(currentRow);
                currentRow = nextElement;
            } else
            {
                nextElement = nextElement.cloneNode(true);
                nextElement.removeAttribute('id');
                currentRow.appendChild(nextElement);
            }
        }
        tBodyNode.appendChild(currentRow);
        tNode.appendChild(tBodyNode);
        var parentDiv = document.createElement("DIV");
        parentDiv.style.display = 'none';
        parentDiv.style.position = 'absolute';
        parentDiv.style.top = "0px";
        parentDiv.style.left = "0px";
        parentDiv.id = this.IDPrefix + id;
        parentDiv.appendChild(tNode);
        var reportDiv = document.getElementById(this.ReportCellId);
        reportDiv.appendChild(parentDiv);
        return parentDiv;
    },
    CreateFixedColumnHeader: function(arr, id)
    {
        var tableID = arr[0];
        if (document.getElementById(this.IDPrefix + id))
            return;
        var tNode = document.getElementById(this.IDPrefix + tableID);
        if (tNode == null)
            return;
        var tNodeOrigWidth = 0;
        if ((tNode.tagName == "TABLE") &&
            Microsoft_ReportingServices_HTMLRenderer_IsIE() &&
            !Microsoft_ReportingServices_HTMLRenderer_IsStandardsMode())
        {
            // If we're in IE Quirks mode, save the original column width which enforces a particular text wrapping
            // behavior.
            // tNode is a TABLE tag, so its first contained TD is the firstChild (TD) of its firstChild (TR) of its firstChild (TBODY).        
            var tNodeTDStyleWidth = tNode.firstChild.firstChild.firstChild.style.width;
            tNodeOrigWidth = Math.round(Microsoft_ReportingServices_HTMLRenderer_ConvertToPx(tNodeTDStyleWidth));
        }
        tNode = tNode.cloneNode(false);
        tNode.removeAttribute('id');
        var tBodyNode = document.createElement("TBODY");
        for (var x = 1; x < arr.length; x++)
        {
            var nextElement = document.getElementById(this.IDPrefix + arr[x]);
            nextElement = nextElement.cloneNode(true);
            nextElement.removeAttribute('id');
            tBodyNode.appendChild(nextElement);
        }
        tNode.appendChild(tBodyNode);
        var parentDiv = document.createElement("DIV");
        parentDiv.style.display = 'none';
        parentDiv.style.position = 'absolute';
        parentDiv.style.top = "0px";
        parentDiv.style.left = "0px";
        parentDiv.id = this.IDPrefix + id;
        parentDiv.appendChild(tNode);
        if (tNodeOrigWidth > 0)
        {
            // Set the new cloned fixed header node's style width to the width which
            // corresponds to the text-wrapping behavior for the column header before scrolling.        
            parentDiv.style.width = tNodeOrigWidth + "px";
            tNode.style.width = tNodeOrigWidth + "px";
        }
        var reportDiv = document.getElementById(this.ReportCellId);
        reportDiv.appendChild(parentDiv);
        return parentDiv;
    },
    ShowFixedTablixHeaders: function(m, fnh, rg, cg, ch, c1, c2, tr)
    {
        var om = document.getElementById(this.IDPrefix + m);
        var ofnh = document.getElementById(this.IDPrefix + fnh);
        var org = document.getElementById(this.IDPrefix + rg);
        var ocg = document.getElementById(this.IDPrefix + cg);
        var och = document.getElementById(this.IDPrefix + ch);
        var oc1 = document.getElementById(this.IDPrefix + c1);
        var oc2 = document.getElementById(this.IDPrefix + c2);
        var otr = document.getElementById(this.IDPrefix + tr);
        var rptDiv = document.getElementById(this.ReportDivId);
        var isIE8StandardsOrLater = Microsoft_ReportingServices_HTMLRenderer_IsIE8OrLater() && Microsoft_ReportingServices_HTMLRenderer_IsStandardsMode();
        var isIEQuirksMode = Microsoft_ReportingServices_HTMLRenderer_IsIE() && !Microsoft_ReportingServices_HTMLRenderer_IsStandardsMode();

        //Calculate the visual scroll offset
        var offsetParent = rptDiv;
        var scT = 0;
        var scL = 0;
        var dscT = 0;
        var clHeight = 0;
        var clWidth = 0;

        var parentWithAuto = rptDiv;
        while (parentWithAuto && parentWithAuto.style && 'auto' != parentWithAuto.style.overflow)
        {
            parentWithAuto = parentWithAuto.parentNode;
        }

        if (!parentWithAuto || !parentWithAuto.style)
        {
            scT = document.body.scrollTop;
            scL = document.body.scrollLeft;
            var htmlElement = document.body.parentNode;
            if (htmlElement && scL == 0 && scT == 0 && (htmlElement.scrollTop != 0 || htmlElement.scrollLeft != 0))
            {
                scT = htmlElement.scrollTop;
                scL = htmlElement.scrollLeft;
            }
        }
        else
        {
            offsetParent = parentWithAuto;
            scT = offsetParent.scrollTop;
            scL = offsetParent.scrollLeft;
            clHeight = offsetParent.clientHeight;
            clWidth = offsetParent.clientWidth;
        }

        //Calculate the offset of the item with the fixedheader relative to the scrollable area
        var offL = 0;
        var offT = 0;

        var o = om;
        while (o && o.id != rptDiv.id)
        {
            if (o.offsetLeft > 0) //Ignore RTL bits
                offL += o.offsetLeft;

            if (o.offsetTop > 0)
            {
                // IE8 standards mode - offsetTop can be negative when column fixedHeaders are moved vertically down.
                offT += o.offsetTop;
            }
            var oOffsetParent = o.offsetParent;
            //Walk the parents looking for either the ReportDivId or the offsetParent
            while (o != oOffsetParent && o.id != rptDiv.id)
            {
                o = o.parentNode;
            }
        }
        if (!o)
            o = document.getElementById(this.ContainerId);
        var rptCell = document.getElementById(this.ReportCellId);

        //Factor in Zoom
        var zt = rptCell.style.zoom;
        if (zt && zt.substring(zt.length - 1) == '%')
        {
            zm = zt.substring(0, zt.length - 1) / 100;
        }
        else
        {
            zm = zt;
        }

        if (!zm || zm == 0) zm = 1;

        var fixedHeaderScaleFactor = zm;

        if (!isIE8StandardsOrLater)
        {
            offL *= zm;
            offT *= zm;
            fixedHeaderScaleFactor = 1;
        }

        //Hide any of the FixedHeader regions that shouldn't be visible
        if (ocg != null) ocg.style.display = 'none';
        if (org != null) org.style.display = 'none';
        if (och != null) och.style.display = 'none';
        var zomoh = om.offsetHeight * zm;
        if (om.offsetHeight == 0)
            zomoh = document.body.offsetHeight * zm;

        var zomow = om.offsetWidth * zm;
        if (om.offsetWidth == 0)
            zomow = document.body.offsetWidth * zm;

        var zofnhot = Math.round(ofnh.offsetTop / fixedHeaderScaleFactor) * zm;

        var zocow = 0;
        if (oc1 && oc2)
        {
            zocow = ((Math.round(oc2.offsetLeft / fixedHeaderScaleFactor) + oc2.offsetWidth) - Math.round(oc1.offsetLeft / fixedHeaderScaleFactor)) * zm;
        }
        // clHeight, clWidth are not scaled in IE8 standards mode, even though offT,scT,offL,scL are.
        if ((scT >= (offT + zomoh - zofnhot)) || (scT + clHeight * fixedHeaderScaleFactor <= offT))
        {
            ocg = null;
        }
        if ((scL + clWidth * fixedHeaderScaleFactor - zocow <= offL) || (scL >= offL + zomow - zocow))
        {
            org = null;
        }

        //If none are visible, return
        if (!ocg && !org)
        {
            return;
        }

        //Update all the sizes
        if (org != null)
        {
            var rows = om.childNodes[0].childNodes;
            var fhrows = org.childNodes[0].childNodes[0].childNodes;
            var notIE7 = !Microsoft_ReportingServices_HTMLRenderer_IsIE() || Microsoft_ReportingServices_HTMLRenderer_IsIE8OrLater();

            var i, j;
            for (i = fhrows.length - 1, j = rows.length - 1; i > 0; i--, j--)
            {
                var rowHeight = rows[j].childNodes[0].offsetHeight;
                if (rows[j].getBoundingClientRect)
                {
                    var rowBoundingRect = rows[j].getBoundingClientRect();
                    var boundingHeight = rowBoundingRect.bottom - rowBoundingRect.top;

                    // Get the max rowspan of all <td> childNodes of this <tr> node.
                    var maxTDRowSpan = Microsoft_ReportingServices_HTMLRenderer_GetMaxChildRowSpan(rows[j]);
                    if (maxTDRowSpan > 1)
                    {
                        if (j + 1 < rows.length)
                        {
                            var nextRowBoundingRect = rows[j + 1].getBoundingClientRect();
                            // Use the bottom row's top and subtract it from this row's top
                            // to get the appropriate height of this row.
                            boundingHeight = nextRowBoundingRect.top - rowBoundingRect.top;
                        }
                    }

                    // The bouding rectangle increases proportionally to zoom.
                    boundingHeight = boundingHeight / zm;

                    if (boundingHeight > rowHeight)
                        rowHeight = boundingHeight;
                }

                if (notIE7 && !rows[j].getAttribute("height")) //Do not write in IE6 or 7
                {
                    rows[j].setAttribute("height", rowHeight);
                }

                fhrows[i].childNodes[0].style.height = rowHeight + "px";
            }
        }
        if (och != null)
        {
            var rows = om.childNodes[0].childNodes;
            var fhrows = och.childNodes[0].childNodes[0].childNodes;
            for (i = 0; i < fhrows.length; i++) fhrows[i].childNodes[0].style.height = rows[i].childNodes[0].offsetHeight + "px";
        }
        if (ocg != null)
        {
            var cols = om.childNodes[0].childNodes[0];
            var omFirstChildWidth = om.childNodes[0].clientWidth;
            // In IE quirks mode, when creating the column fixed header,
            // the style width is explicitly set on that fixed header. Don't
            // overwrite the style width if the overwriting value is 0.
            if (omFirstChildWidth > 0 || !isIEQuirksMode)
            {
                ocg.childNodes[0].style.width = omFirstChildWidth + "px";
            }
            for (i = 0; i < cols.childNodes.length; i++)
            {
                var colsChildWidth = cols.childNodes[i].offsetWidth;
                if (colsChildWidth > 0 || !isIEQuirksMode)
                {
                    ocg.childNodes[0].childNodes[0].childNodes[0].childNodes[i].style.width = colsChildWidth + "px";
                }
            }
        }

        //Position the FixedHeaders
        if (ocg != null)
        {
            ocg.style.zoom = zt;
            ocg.style.left = Math.round(offL / fixedHeaderScaleFactor) + "px";
            var zdbch = document.body.clientHeight;

            if (!((offT > scT) && ((scT + zdbch) > offT)))
            {
                ocg.style.display = '';
                var topOffset = scT;
                ocg.style.top = Math.round(topOffset / fixedHeaderScaleFactor) + "px";
            }
        }
        var zocol = 0;
        if (oc1)
        {
            zocol = oc1.offsetLeft * zm;
        }
        if (org != null)
        {
            org.style.zoom = zt;
            zoccw = ((Math.round(oc2.offsetLeft / fixedHeaderScaleFactor) + oc2.offsetWidth) * zm) - Math.max(scL, Math.round(oc1.offsetLeft / fixedHeaderScaleFactor) * zm);
            zoccw = Math.max(0, zoccw);
            var zomol = Math.round(om.offsetLeft / fixedHeaderScaleFactor) * zm;
            if ((scL > (zocol + offL)) && (scL < offL + zomow - zocow))
            {
                org.style.display = '';
                var topOffset = offT - dscT;
                var leftOffset = scL;
                org.style.top = Math.round(topOffset / fixedHeaderScaleFactor) + "px";
                org.style.left = Math.round(leftOffset / fixedHeaderScaleFactor) + "px";
                org.style.width = zoccw + "px";
            }
            else if (((scL + rptDiv.clientWidth) < (zocol + zocow + offL)) && (scL + rptDiv.clientWidth - zoccw > offL + zomol))
            {
                org.style.display = '';
                org.style.top = Math.round((offT - dscT) / fixedHeaderScaleFactor) + "px";
                org.style.left = Math.round((scL + rptDiv.clientWidth - zoccw) / fixedHeaderScaleFactor) + "px";
                org.style.width = zoccw + "px";
            }
        }
        if (och != null && org && ocg && org.style.display == '' && ocg.style.display == '')
        {
            och.style.zoom = zt;
            och.style.display = '';
            och.style.top = ocg.style.top;
            och.style.left = org.style.left;
            och.style.width = org.style.width;
        }
    }
}
function Microsoft_ReportingServices_HTMLRenderer_GrowTablixTextBoxes(topElementId)
{
    var topElement = document;
    if (topElementId)
    {
        topElement = document.getElementById(topElementId);
        if(!topElement)
          topElement = document;
    }
    var tags = topElement.getElementsByTagName("div");
    for (var i = 0; i < tags.length; i++)
    {
        if (tags[i].getAttribute("nogrow"))
        {
            var tag = tags[i];
            var parent = tag.parentNode;
            var targetHeight = parent.offsetHeight;
            if (tag.offsetHeight != targetHeight)
            {
                //Update Height
                var divTargetHeight = targetHeight;
                if (tag.scrollHeight < targetHeight)
                {
                    divTargetHeight = tag.scrollHeight;
                }

                tag.style.height = divTargetHeight + "px";
                //Borders or paddings can affect the sizing.  Make sure the child doesn't alter the size of the parent.
                diff = parent.offsetHeight - targetHeight;
                if (diff > 0)
                    tag.style.height = (divTargetHeight - diff) + "px";

                //Which one first?  Width or height?
                var targetWidth = parent.offsetWidth;
                var divTargetWidth = targetWidth;
                var useScrollWidth = false;
                if (tag.scrollWidth > targetWidth)
                {
                    divTargetWidth = tag.scrollWidth;
                    useScrollWidth = true;
                }
                    
                tag.style.width = divTargetWidth + "px";
                //Borders or paddings can affect the sizing.  Make sure the child doesn't alter the size of the parent.
                var diff = parent.offsetWidth - targetWidth;
                if (diff > 0 && !useScrollWidth)
                {
                    //Allow the width to grow if the scrollwidth is wider than the current width.  Particularly important for Sorts.
                    tag.style.width = (targetWidth - diff) + "px";
                }
            }
            //Do this calculation once
            tag.removeAttribute("nogrow");
        }
    }
}function Microsoft_ReportingServices_HTMLRenderer_ScaleImageConsolidation(topElementId, reportCellId)
{

    var topElement = document;
    if (topElementId)
    {
        topElement = document.getElementById(topElementId);
        if (!topElement)
            topElement = document;
    }

    var stdMode = Microsoft_ReportingServices_HTMLRenderer_IsStandardsMode();
    var isIE = Microsoft_ReportingServices_HTMLRenderer_IsIE();
    var isIE7OrLess = !Microsoft_ReportingServices_HTMLRenderer_IsIE8OrLater();

    var imgs = topElement.getElementsByTagName("div");
    for (var i = 0; i < imgs.length; i++)
    {
        var div = imgs[i];
        //All Consolidated Images requiring scaling will have the "imgConDiv" attribute
        var imgType = div.getAttribute("imgConImage");
        if (!imgType)
        {
            continue;
        }

        var divWidth = div.parentNode.clientWidth;
        var divHeight = div.parentNode.clientHeight;

        if (stdMode)
        {
            if (divWidth == 0 && div.getAttribute("origWidth"))
            {
                divWidth = div.getAttribute("origWidth");
            }
            else
            {
                divWidth = divWidth + "px";
            }

            if (divHeight == 0 && div.getAttribute("origHeight"))
            {
                divHeight = div.getAttribute("origHeight");
            }
            else
            {
                divHeight = divHeight + "px";
            }
        }

        
        //If standards mode, set position:relative on the outer div.
	if(isIE)
	{
	    if(stdMode)
            {
                div.style.position = "relative";
		if(isIE7OrLess)
                {
                  var offsets = Microsoft_ReportingServices_HTMLRenderer_CalculateOffset(topElement, div.parentNode);
                  div.setAttribute("origLeft", offsets.left);
                  div.setAttribute("origTop", offsets.top);
                }
            }
            //No relative for quirks mode
        }
        else
        {
          div.style.position = "relative";
        }

        if (imgType == "Fit")
        {
            var height = parseFloat(divHeight);
            var width = parseFloat(divWidth);
            
            height = Microsoft_ReportingServices_HTMLRenderer_SubtractVerticalPaddings(div.parentNode, height);
            if (height < 0)
            {
                height = 1;
            }            
            width = Microsoft_ReportingServices_HTMLRenderer_SubtractHorizontalPaddings(div.parentNode, width);
            if (width < 0)
            {
                width = 1;
            }


            var imgsInDiv = div.getElementsByTagName("IMG");
            if (imgsInDiv.length == 0)
                continue;
            var img = imgsInDiv[0];

            // div for image started out as 1px by 1px (to prevent effects of growth due to large paddings.
            // Set the div height and width back to original imageConsolidation sizes (from attributes "imgConWidth" and
            // "imgConHeight").
            div.style.width = div.getAttribute("imgConWidth") + "px";
            div.style.height = div.getAttribute("imgConHeight") + "px";
            div.removeAttribute("imgConWidth");
            div.removeAttribute("imgConHeight");

            //Calculate the scaling factor
            var xScale = width / parseInt(div.style.width);
            var yScale = height / parseInt(div.style.height);
            var endWidth = xScale * parseInt(img.width);
            var endHeight = yScale * parseInt(img.height);                                      
            //Scale the Consolidated Image
            img.width = endWidth;
            img.height = endHeight;
            div.style.width = width + "px";
            div.style.height = height + "px";

            //Scale the Offsets within the Image
            var topOffset = (parseInt(img.style.top) * yScale);
            var leftOffset = (parseInt(img.style.left) * xScale);
            img.style.top = topOffset + "px";
            img.style.left = leftOffset + "px";
        }
        else if (imgType == "Clip")
        {
            div.style.height = divHeight;
            div.style.width = divWidth;
        }
    }
    
}

function Microsoft_ReportingServices_HTMLRenderer_ScaleImageUpdateZoom(topElementId, reportCellId)
{
    //Only for IE6/7 in standards mode
    if (Microsoft_ReportingServices_HTMLRenderer_IsStandardsMode())
    {
        if (!Microsoft_ReportingServices_HTMLRenderer_IsIE()
      || Microsoft_ReportingServices_HTMLRenderer_IsIE8OrLater())
            return;
    }
    else
    {
        return;
    }

    var zoom = Microsoft_ReportingServices_HTMLRenderer_CalculateZoom(reportCellId);
    var topElement = document;
    if (topElementId)
    {
        topElement = document.getElementById(topElementId);
        if (!topElement)
            topElement = document;
    }
    var reportDiv = topElement;     

    var imgs = topElement.getElementsByTagName("div");
    for (var i = 0; i < imgs.length; i++)
    {
        var div = imgs[i];
        var imgType = div.getAttribute("imgConImage");
        if (imgType == "Fit" || imgType == "AutoSize" || imgType == "Clip")
        {
            if (zoom != 1)
            {
                if (div.style.position == "relative")
                {
                    div.style.position = "absolute";
                }

                var offsets = Microsoft_ReportingServices_HTMLRenderer_CalculateOffset(reportDiv, div.parentNode);

                div.style.left = (offsets.left * zoom) + "px";
                div.style.top = (offsets.top * zoom) + "px";
                div.style.zoom = zoom;
            }
            else
            {
                if (div.style.position == "absolute")
                {
                    div.style.position = "relative";
                }
                
                div.style.left = "auto";
                div.style.top = "auto";
                div.style.zoom = "normal";
            }
        }
    }
}

function CalculateDocumentOffset(element)
{
    /// <summary>
    /// Returns the offset in pixesl of the given element from the body
    /// </summary>
    if (!element || !element.ownerDocument)
    {
        throw Error.argumentNull("element");
    }

    var box = element.getBoundingClientRect();
    var doc = element.ownerDocument;
    var body = doc.body;
    var docElem = doc.documentElement;

    // docElem.clientTop = non IE, body.clientTop = IE
    var clientTop = docElem.clientTop || body.clientTop || 0;
    var clientLeft = docElem.clientLeft || body.clientLeft || 0;

    // pageX/YOffset = FF, Safari docElem.scrollTop/Left = IE standards body.scrollTop/Left = IE quirks
    var top = box.top + (self.pageYOffset || docElem.scrollTop || body.scrollTop || 0) - clientTop;
    var left = box.left + (self.pageXOffset || docElem.scrollLeft || body.scrollLeft || 0) - clientLeft;

    return { top: top, left: left };
}

function Microsoft_ReportingServices_HTMLRenderer_ScaleImageForFit(topElementId)
{
    var topElement = document;
    if (topElementId)
    {
        topElement = document.getElementById(topElementId);
        if(!topElement)
          topElement = document;
    }
    var imgs = topElement.getElementsByTagName("div");

    // Need to separate loops for setting width and height (which were consolidated before).
    // IE7 standards mode sometimes does not respect first <td> element's height on a <tr> element,
    // until javascript execution causes re-rendering of page. Executing the width loop first
    // will trigger re-rendering of page, after which the loop to set the heights will have the correct
    // heights from the images.
    for (var i = 0; i < imgs.length; i++)
    {
        var div = imgs[i];
        if (div.getAttribute("imgFitDiv"))
        {
            var imgsInDiv = div.getElementsByTagName("IMG");
            if (imgsInDiv.length == 0)
                continue;
            var img = imgsInDiv[0];

            var width = div.parentNode.clientWidth;
            width = Microsoft_ReportingServices_HTMLRenderer_SubtractHorizontalPaddings(div.parentNode, width);
            if (width < 0)
            {
                width = 1;
            }

            img.width = width;
            if (img.width != width)
            {
                img.style.width = width + "px";
            }
        }
    }

    for (var i = 0; i < imgs.length; i++)
    {
        var div = imgs[i];
        if (div.getAttribute("imgFitDiv"))
        {
            var imgsInDiv = div.getElementsByTagName("IMG");
            if (imgsInDiv.length == 0)
                continue;
            var img = imgsInDiv[0];

            var height = div.parentNode.clientHeight;
            height = Microsoft_ReportingServices_HTMLRenderer_SubtractVerticalPaddings(div.parentNode, height);
            if (height < 0)
            {
                height = 1;
            }

            img.height = height;

            if (img.height != height)
            {
                img.style.height = height + "px";
            }
        }
    }
}

if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();






























Function.__typeName = "Function";
Function.__class = true;
Function.createCallback = function(b, a) { return function() { var e = arguments.length; if (e > 0) { var d = []; for (var c = 0; c < e; c++) d[c] = arguments[c];
            d[e] = a; return b.apply(this, d) } return b.call(this, a) } };
Function.createDelegate = function(a, b) { return function() { return b.apply(a, arguments) } };
Function.emptyFunction = Function.emptyMethod = function() {};
Function._validateParams = function(e, c) { var a;
    a = Function._validateParameterCount(e, c); if (a) { a.popStackFrame(); return a } for (var b = 0; b < e.length; b++) { var d = c[Math.min(b, c.length - 1)],
            f = d.name; if (d.parameterArray) f += "[" + (b - c.length + 1) + "]";
        a = Function._validateParameter(e[b], d, f); if (a) { a.popStackFrame(); return a } } return null };
Function._validateParameterCount = function(e, a) { var c = a.length,
        d = 0; for (var b = 0; b < a.length; b++)
        if (a[b].parameterArray) c = Number.MAX_VALUE;
        else if (!a[b].optional) d++; if (e.length < d || e.length > c) { var f = Error.parameterCount();
        f.popStackFrame(); return f } return null };
Function._validateParameter = function(c, a, h) { var b, g = a.type,
        l = !!a.integer,
        k = !!a.domElement,
        m = !!a.mayBeNull;
    b = Function._validateParameterType(c, g, l, k, m, h); if (b) { b.popStackFrame(); return b } var e = a.elementType,
        f = !!a.elementMayBeNull; if (g === Array && typeof c !== "undefined" && c !== null && (e || !f)) { var j = !!a.elementInteger,
            i = !!a.elementDomElement; for (var d = 0; d < c.length; d++) { var n = c[d];
            b = Function._validateParameterType(n, e, j, i, f, h + "[" + d + "]"); if (b) { b.popStackFrame(); return b } } } return null };
Function._validateParameterType = function(a, c, n, m, k, d) { var b; if (typeof a === "undefined")
        if (k) return null;
        else { b = Error.argumentUndefined(d);
            b.popStackFrame(); return b }
    if (a === null)
        if (k) return null;
        else { b = Error.argumentNull(d);
            b.popStackFrame(); return b }
    if (c && c.__enum) { if (typeof a !== "number") { b = Error.argumentType(d, Object.getType(a), c);
            b.popStackFrame(); return b } if (a % 1 === 0) { var e = c.prototype; if (!c.__flags || a === 0) { for (var i in e)
                    if (e[i] === a) return null } else { var l = a; for (var i in e) { var f = e[i]; if (f === 0) continue; if ((f & a) === f) l -= f; if (l === 0) return null } } } b = Error.argumentOutOfRange(d, a, String.format(Sys.Res.enumInvalidValue, a, c.getName()));
        b.popStackFrame(); return b } if (m) { var h; if (typeof a.nodeType !== "number") { var g = a.ownerDocument || a.document || a; if (g != a) { var j = g.defaultView || g.parentWindow;
                h = j != a && !(j.document && a.document && j.document === a.document) } else h = typeof g.body === "undefined" } else h = a.nodeType === 3; if (h) { b = Error.argument(d, Sys.Res.argumentDomElement);
            b.popStackFrame(); return b } } if (c && !c.isInstanceOfType(a)) { b = Error.argumentType(d, Object.getType(a), c);
        b.popStackFrame(); return b } if (c === Number && n)
        if (a % 1 !== 0) { b = Error.argumentOutOfRange(d, a, Sys.Res.argumentInteger);
            b.popStackFrame(); return b }
    return null };
Error.__typeName = "Error";
Error.__class = true;
Error.create = function(d, b) { var a = new Error(d);
    a.message = d; if (b)
        for (var c in b) a[c] = b[c];
    a.popStackFrame(); return a };
Error.argument = function(a, c) { var b = "Sys.ArgumentException: " + (c ? c : Sys.Res.argument); if (a) b += "\n" + String.format(Sys.Res.paramName, a); var d = Error.create(b, { name: "Sys.ArgumentException", paramName: a });
    d.popStackFrame(); return d };
Error.argumentNull = function(a, c) { var b = "Sys.ArgumentNullException: " + (c ? c : Sys.Res.argumentNull); if (a) b += "\n" + String.format(Sys.Res.paramName, a); var d = Error.create(b, { name: "Sys.ArgumentNullException", paramName: a });
    d.popStackFrame(); return d };
Error.argumentOutOfRange = function(c, a, d) { var b = "Sys.ArgumentOutOfRangeException: " + (d ? d : Sys.Res.argumentOutOfRange); if (c) b += "\n" + String.format(Sys.Res.paramName, c); if (typeof a !== "undefined" && a !== null) b += "\n" + String.format(Sys.Res.actualValue, a); var e = Error.create(b, { name: "Sys.ArgumentOutOfRangeException", paramName: c, actualValue: a });
    e.popStackFrame(); return e };
Error.argumentType = function(d, c, b, e) { var a = "Sys.ArgumentTypeException: "; if (e) a += e;
    else if (c && b) a += String.format(Sys.Res.argumentTypeWithTypes, c.getName(), b.getName());
    else a += Sys.Res.argumentType; if (d) a += "\n" + String.format(Sys.Res.paramName, d); var f = Error.create(a, { name: "Sys.ArgumentTypeException", paramName: d, actualType: c, expectedType: b });
    f.popStackFrame(); return f };
Error.argumentUndefined = function(a, c) { var b = "Sys.ArgumentUndefinedException: " + (c ? c : Sys.Res.argumentUndefined); if (a) b += "\n" + String.format(Sys.Res.paramName, a); var d = Error.create(b, { name: "Sys.ArgumentUndefinedException", paramName: a });
    d.popStackFrame(); return d };
Error.format = function(a) { var c = "Sys.FormatException: " + (a ? a : Sys.Res.format),
        b = Error.create(c, { name: "Sys.FormatException" });
    b.popStackFrame(); return b };
Error.invalidOperation = function(a) { var c = "Sys.InvalidOperationException: " + (a ? a : Sys.Res.invalidOperation),
        b = Error.create(c, { name: "Sys.InvalidOperationException" });
    b.popStackFrame(); return b };
Error.notImplemented = function(a) { var c = "Sys.NotImplementedException: " + (a ? a : Sys.Res.notImplemented),
        b = Error.create(c, { name: "Sys.NotImplementedException" });
    b.popStackFrame(); return b };
Error.parameterCount = function(a) { var c = "Sys.ParameterCountException: " + (a ? a : Sys.Res.parameterCount),
        b = Error.create(c, { name: "Sys.ParameterCountException" });
    b.popStackFrame(); return b };
Error.prototype.popStackFrame = function() { if (typeof this.stack === "undefined" || this.stack === null || typeof this.fileName === "undefined" || this.fileName === null || typeof this.lineNumber === "undefined" || this.lineNumber === null) return; var a = this.stack.split("\n"),
        c = a[0],
        e = this.fileName + ":" + this.lineNumber; while (typeof c !== "undefined" && c !== null && c.indexOf(e) === -1) { a.shift();
        c = a[0] } var d = a[1]; if (typeof d === "undefined" || d === null) return; var b = d.match(/@(.*):(\d+)$/); if (typeof b === "undefined" || b === null) return;
    this.fileName = b[1];
    this.lineNumber = parseInt(b[2]);
    a.shift();
    this.stack = a.join("\n") };
Object.__typeName = "Object";
Object.__class = true;
Object.getType = function(b) { var a = b.constructor; if (!a || typeof a !== "function" || !a.__typeName || a.__typeName === "Object") return Object; return a };
Object.getTypeName = function(a) { return Object.getType(a).getName() };
String.__typeName = "String";
String.__class = true;
String.prototype.endsWith = function(a) { return this.substr(this.length - a.length) === a };
String.prototype.startsWith = function(a) { return this.substr(0, a.length) === a };
String.prototype.trim = function() { return this.replace(/^\s+|\s+$/g, "") };
String.prototype.trimEnd = function() { return this.replace(/\s+$/, "") };
String.prototype.trimStart = function() { return this.replace(/^\s+/, "") };
String.format = function() { return String._toFormattedString(false, arguments) };
String.localeFormat = function() { return String._toFormattedString(true, arguments) };
String._toFormattedString = function(l, j) { var c = "",
        e = j[0]; for (var a = 0; true;) { var f = e.indexOf("{", a),
            d = e.indexOf("}", a); if (f < 0 && d < 0) { c += e.slice(a); break } if (d > 0 && (d < f || f < 0)) { c += e.slice(a, d + 1);
            a = d + 2; continue } c += e.slice(a, f);
        a = f + 1; if (e.charAt(a) === "{") { c += "{";
            a++; continue } if (d < 0) break; var h = e.substring(a, d),
            g = h.indexOf(":"),
            k = parseInt(g < 0 ? h : h.substring(0, g), 10) + 1,
            i = g < 0 ? "" : h.substring(g + 1),
            b = j[k]; if (typeof b === "undefined" || b === null) b = ""; if (b.toFormattedString) c += b.toFormattedString(i);
        else if (l && b.localeFormat) c += b.localeFormat(i);
        else if (b.format) c += b.format(i);
        else c += b.toString();
        a = d + 1 } return c };
Boolean.__typeName = "Boolean";
Boolean.__class = true;
Boolean.parse = function(b) { var a = b.trim().toLowerCase(); if (a === "false") return false; if (a === "true") return true };
Date.__typeName = "Date";
Date.__class = true;
Date._appendPreOrPostMatch = function(e, b) { var d = 0,
        a = false; for (var c = 0, g = e.length; c < g; c++) { var f = e.charAt(c); switch (f) {
            case "'":
                if (a) b.append("'");
                else d++;
                a = false; break;
            case "\\":
                if (a) b.append("\\");
                a = !a; break;
            default:
                b.append(f);
                a = false } } return d };
Date._expandFormat = function(a, b) { if (!b) b = "F"; if (b.length === 1) switch (b) {
        case "d":
            return a.ShortDatePattern;
        case "D":
            return a.LongDatePattern;
        case "t":
            return a.ShortTimePattern;
        case "T":
            return a.LongTimePattern;
        case "F":
            return a.FullDateTimePattern;
        case "M":
        case "m":
            return a.MonthDayPattern;
        case "s":
            return a.SortableDateTimePattern;
        case "Y":
        case "y":
            return a.YearMonthPattern;
        default:
            throw Error.format(Sys.Res.formatInvalidString) }
    return b };
Date._expandYear = function(c, a) { if (a < 100) { var b = (new Date).getFullYear();
        a += b - b % 100; if (a > c.Calendar.TwoDigitYearMax) return a - 100 } return a };
Date._getParseRegExp = function(b, e) { if (!b._parseRegExp) b._parseRegExp = {};
    else if (b._parseRegExp[e]) return b._parseRegExp[e]; var c = Date._expandFormat(b, e);
    c = c.replace(/([\^\$\.\*\+\?\|\[\]\(\)\{\}])/g, "\\\\$1"); var a = new Sys.StringBuilder("^"),
        j = [],
        f = 0,
        i = 0,
        h = Date._getTokenRegExp(),
        d; while ((d = h.exec(c)) !== null) { var l = c.slice(f, d.index);
        f = h.lastIndex;
        i += Date._appendPreOrPostMatch(l, a); if (i % 2 === 1) { a.append(d[0]); continue } switch (d[0]) {
            case "dddd":
            case "ddd":
            case "MMMM":
            case "MMM":
                a.append("(\\D+)"); break;
            case "tt":
            case "t":
                a.append("(\\D*)"); break;
            case "yyyy":
                a.append("(\\d{4})"); break;
            case "fff":
                a.append("(\\d{3})"); break;
            case "ff":
                a.append("(\\d{2})"); break;
            case "f":
                a.append("(\\d)"); break;
            case "dd":
            case "d":
            case "MM":
            case "M":
            case "yy":
            case "y":
            case "HH":
            case "H":
            case "hh":
            case "h":
            case "mm":
            case "m":
            case "ss":
            case "s":
                a.append("(\\d\\d?)"); break;
            case "zzz":
                a.append("([+-]?\\d\\d?:\\d{2})"); break;
            case "zz":
            case "z":
                a.append("([+-]?\\d\\d?)") } Array.add(j, d[0]) } Date._appendPreOrPostMatch(c.slice(f), a);
    a.append("$"); var k = a.toString().replace(/\s+/g, "\\s+"),
        g = { "regExp": k, "groups": j };
    b._parseRegExp[e] = g; return g };
Date._getTokenRegExp = function() { return /dddd|ddd|dd|d|MMMM|MMM|MM|M|yyyy|yy|y|hh|h|HH|H|mm|m|ss|s|tt|t|fff|ff|f|zzz|zz|z/g };
Date.parseLocale = function(a) { return Date._parse(a, Sys.CultureInfo.CurrentCulture, arguments) };
Date.parseInvariant = function(a) { return Date._parse(a, Sys.CultureInfo.InvariantCulture, arguments) };
Date._parse = function(g, c, h) { var e = false; for (var a = 1, i = h.length; a < i; a++) { var f = h[a]; if (f) { e = true; var b = Date._parseExact(g, f, c); if (b) return b } } if (!e) { var d = c._getDateTimeFormats(); for (var a = 0, i = d.length; a < i; a++) { var b = Date._parseExact(g, d[a], c); if (b) return b } } return null };
Date._parseExact = function(s, y, j) { s = s.trim(); var m = j.dateTimeFormat,
        v = Date._getParseRegExp(m, y),
        x = (new RegExp(v.regExp)).exec(s); if (x === null) return null; var w = v.groups,
        f = null,
        c = null,
        h = null,
        g = null,
        d = 0,
        n = 0,
        o = 0,
        e = 0,
        k = null,
        r = false; for (var p = 0, z = w.length; p < z; p++) { var a = x[p + 1]; if (a) switch (w[p]) {
            case "dd":
            case "d":
                h = parseInt(a, 10); if (h < 1 || h > 31) return null; break;
            case "MMMM":
                c = j._getMonthIndex(a); if (c < 0 || c > 11) return null; break;
            case "MMM":
                c = j._getAbbrMonthIndex(a); if (c < 0 || c > 11) return null; break;
            case "M":
            case "MM":
                var c = parseInt(a, 10) - 1; if (c < 0 || c > 11) return null; break;
            case "y":
            case "yy":
                f = Date._expandYear(m, parseInt(a, 10)); if (f < 0 || f > 9999) return null; break;
            case "yyyy":
                f = parseInt(a, 10); if (f < 0 || f > 9999) return null; break;
            case "h":
            case "hh":
                d = parseInt(a, 10); if (d === 12) d = 0; if (d < 0 || d > 11) return null; break;
            case "H":
            case "HH":
                d = parseInt(a, 10); if (d < 0 || d > 23) return null; break;
            case "m":
            case "mm":
                n = parseInt(a, 10); if (n < 0 || n > 59) return null; break;
            case "s":
            case "ss":
                o = parseInt(a, 10); if (o < 0 || o > 59) return null; break;
            case "tt":
            case "t":
                var u = a.toUpperCase();
                r = u === m.PMDesignator.toUpperCase(); if (!r && u !== m.AMDesignator.toUpperCase()) return null; break;
            case "f":
                e = parseInt(a, 10) * 100; if (e < 0 || e > 999) return null; break;
            case "ff":
                e = parseInt(a, 10) * 10; if (e < 0 || e > 999) return null; break;
            case "fff":
                e = parseInt(a, 10); if (e < 0 || e > 999) return null; break;
            case "dddd":
                g = j._getDayIndex(a); if (g < 0 || g > 6) return null; break;
            case "ddd":
                g = j._getAbbrDayIndex(a); if (g < 0 || g > 6) return null; break;
            case "zzz":
                var q = a.split(/:/); if (q.length !== 2) return null; var i = parseInt(q[0], 10); if (i < -12 || i > 13) return null; var l = parseInt(q[1], 10); if (l < 0 || l > 59) return null;
                k = i * 60 + (a.startsWith("-") ? -l : l); break;
            case "z":
            case "zz":
                var i = parseInt(a, 10); if (i < -12 || i > 13) return null;
                k = i * 60 } } var b = new Date; if (f === null) f = b.getFullYear(); if (c === null) c = b.getMonth(); if (h === null) h = b.getDate();
    b.setFullYear(f, c, h); if (b.getDate() !== h) return null; if (g !== null && b.getDay() !== g) return null; if (r && d < 12) d += 12;
    b.setHours(d, n, o, e); if (k !== null) { var t = b.getMinutes() - (k + b.getTimezoneOffset());
        b.setHours(b.getHours() + parseInt(t / 60, 10), t % 60) } return b };
Date.prototype.format = function(a) { return this._toFormattedString(a, Sys.CultureInfo.InvariantCulture) };
Date.prototype.localeFormat = function(a) { return this._toFormattedString(a, Sys.CultureInfo.CurrentCulture) };
Date.prototype._toFormattedString = function(e, h) { if (!e || e.length === 0 || e === "i")
        if (h && h.name.length > 0) return this.toLocaleString();
        else return this.toString(); var d = h.dateTimeFormat;
    e = Date._expandFormat(d, e); var a = new Sys.StringBuilder,
        b;

    function c(a) { if (a < 10) return "0" + a; return a.toString() }

    function g(a) { if (a < 10) return "00" + a; if (a < 100) return "0" + a; return a.toString() } var j = 0,
        i = Date._getTokenRegExp(); for (; true;) { var l = i.lastIndex,
            f = i.exec(e),
            k = e.slice(l, f ? f.index : e.length);
        j += Date._appendPreOrPostMatch(k, a); if (!f) break; if (j % 2 === 1) { a.append(f[0]); continue } switch (f[0]) {
            case "dddd":
                a.append(d.DayNames[this.getDay()]); break;
            case "ddd":
                a.append(d.AbbreviatedDayNames[this.getDay()]); break;
            case "dd":
                a.append(c(this.getDate())); break;
            case "d":
                a.append(this.getDate()); break;
            case "MMMM":
                a.append(d.MonthNames[this.getMonth()]); break;
            case "MMM":
                a.append(d.AbbreviatedMonthNames[this.getMonth()]); break;
            case "MM":
                a.append(c(this.getMonth() + 1)); break;
            case "M":
                a.append(this.getMonth() + 1); break;
            case "yyyy":
                a.append(this.getFullYear()); break;
            case "yy":
                a.append(c(this.getFullYear() % 100)); break;
            case "y":
                a.append(this.getFullYear() % 100); break;
            case "hh":
                b = this.getHours() % 12; if (b === 0) b = 12;
                a.append(c(b)); break;
            case "h":
                b = this.getHours() % 12; if (b === 0) b = 12;
                a.append(b); break;
            case "HH":
                a.append(c(this.getHours())); break;
            case "H":
                a.append(this.getHours()); break;
            case "mm":
                a.append(c(this.getMinutes())); break;
            case "m":
                a.append(this.getMinutes()); break;
            case "ss":
                a.append(c(this.getSeconds())); break;
            case "s":
                a.append(this.getSeconds()); break;
            case "tt":
                a.append(this.getHours() < 12 ? d.AMDesignator : d.PMDesignator); break;
            case "t":
                a.append((this.getHours() < 12 ? d.AMDesignator : d.PMDesignator).charAt(0)); break;
            case "f":
                a.append(g(this.getMilliseconds()).charAt(0)); break;
            case "ff":
                a.append(g(this.getMilliseconds()).substr(0, 2)); break;
            case "fff":
                a.append(g(this.getMilliseconds())); break;
            case "z":
                b = this.getTimezoneOffset() / 60;
                a.append((b <= 0 ? "+" : "-") + Math.floor(Math.abs(b))); break;
            case "zz":
                b = this.getTimezoneOffset() / 60;
                a.append((b <= 0 ? "+" : "-") + c(Math.floor(Math.abs(b)))); break;
            case "zzz":
                b = this.getTimezoneOffset() / 60;
                a.append((b <= 0 ? "+" : "-") + c(Math.floor(Math.abs(b))) + d.TimeSeparator + c(Math.abs(this.getTimezoneOffset() % 60))) } } return a.toString() };
Number.__typeName = "Number";
Number.__class = true;
Number.parseLocale = function(a) { return Number._parse(a, Sys.CultureInfo.CurrentCulture) };
Number.parseInvariant = function(a) { return Number._parse(a, Sys.CultureInfo.InvariantCulture) };
Number._parse = function(b, o) { b = b.trim(); if (b.match(/^[+-]?infinity$/i)) return parseFloat(b); if (b.match(/^0x[a-f0-9]+$/i)) return parseInt(b); var a = o.numberFormat,
        g = Number._parseNumberNegativePattern(b, a, a.NumberNegativePattern),
        h = g[0],
        e = g[1]; if (h === "" && a.NumberNegativePattern !== 1) { g = Number._parseNumberNegativePattern(b, a, 1);
        h = g[0];
        e = g[1] } if (h === "") h = "+"; var j, d, f = e.indexOf("e"); if (f < 0) f = e.indexOf("E"); if (f < 0) { d = e;
        j = null } else { d = e.substr(0, f);
        j = e.substr(f + 1) } var c, k, m = d.indexOf(a.NumberDecimalSeparator); if (m < 0) { c = d;
        k = null } else { c = d.substr(0, m);
        k = d.substr(m + a.NumberDecimalSeparator.length) } c = c.split(a.NumberGroupSeparator).join(""); var n = a.NumberGroupSeparator.replace(/\u00A0/g, " "); if (a.NumberGroupSeparator !== n) c = c.split(n).join(""); var l = h + c; if (k !== null) l += "." + k; if (j !== null) { var i = Number._parseNumberNegativePattern(j, a, 1); if (i[0] === "") i[0] = "+";
        l += "e" + i[0] + i[1] } if (l.match(/^[+-]?\d*\.?\d*(e[+-]?\d+)?$/)) return parseFloat(l); return Number.NaN };
Number._parseNumberNegativePattern = function(a, d, e) { var b = d.NegativeSign,
        c = d.PositiveSign; switch (e) {
        case 4:
            b = " " + b;
            c = " " + c;
        case 3:
            if (a.endsWith(b)) return ["-", a.substr(0, a.length - b.length)];
            else if (a.endsWith(c)) return ["+", a.substr(0, a.length - c.length)]; break;
        case 2:
            b += " ";
            c += " ";
        case 1:
            if (a.startsWith(b)) return ["-", a.substr(b.length)];
            else if (a.startsWith(c)) return ["+", a.substr(c.length)]; break;
        case 0:
            if (a.startsWith("(") && a.endsWith(")")) return ["-", a.substr(1, a.length - 2)] } return ["", a] };
Number.prototype.format = function(a) { return this._toFormattedString(a, Sys.CultureInfo.InvariantCulture) };
Number.prototype.localeFormat = function(a) { return this._toFormattedString(a, Sys.CultureInfo.CurrentCulture) };
Number.prototype._toFormattedString = function(d, j) { if (!d || d.length === 0 || d === "i")
        if (j && j.name.length > 0) return this.toLocaleString();
        else return this.toString(); var o = ["n %", "n%", "%n"],
        n = ["-n %", "-n%", "-%n"],
        p = ["(n)", "-n", "- n", "n-", "n -"],
        m = ["$n", "n$", "$ n", "n $"],
        l = ["($n)", "-$n", "$-n", "$n-", "(n$)", "-n$", "n-$", "n$-", "-n $", "-$ n", "n $-", "$ n-", "$ -n", "n- $", "($ n)", "(n $)"];

    function g(a, c, d) { for (var b = a.length; b < c; b++) a = d ? "0" + a : a + "0"; return a }

    function i(j, i, l, n, p) { var h = l[0],
            k = 1,
            o = Math.pow(10, i),
            m = Math.round(j * o) / o; if (!isFinite(m)) m = j;
        j = m; var b = j.toString(),
            a = "",
            c, e = b.split(/e/i);
        b = e[0];
        c = e.length > 1 ? parseInt(e[1]) : 0;
        e = b.split(".");
        b = e[0];
        a = e.length > 1 ? e[1] : ""; var q; if (c > 0) { a = g(a, c, false);
            b += a.slice(0, c);
            a = a.substr(c) } else if (c < 0) { c = -c;
            b = g(b, c + 1, true);
            a = b.slice(-c, b.length) + a;
            b = b.slice(0, -c) } if (i > 0) { if (a.length > i) a = a.slice(0, i);
            else a = g(a, i, false);
            a = p + a } else a = ""; var d = b.length - 1,
            f = ""; while (d >= 0) { if (h === 0 || h > d)
                if (f.length > 0) return b.slice(0, d + 1) + n + f + a;
                else return b.slice(0, d + 1) + a; if (f.length > 0) f = b.slice(d - h + 1, d + 1) + n + f;
            else f = b.slice(d - h + 1, d + 1);
            d -= h; if (k < l.length) { h = l[k];
                k++ } } return b.slice(0, d + 1) + n + f + a } var a = j.numberFormat,
        e = Math.abs(this); if (!d) d = "D"; var b = -1; if (d.length > 1) b = parseInt(d.slice(1), 10); var c; switch (d.charAt(0)) {
        case "d":
        case "D":
            c = "n"; if (b !== -1) e = g("" + e, b, true); if (this < 0) e = -e; break;
        case "c":
        case "C":
            if (this < 0) c = l[a.CurrencyNegativePattern];
            else c = m[a.CurrencyPositivePattern]; if (b === -1) b = a.CurrencyDecimalDigits;
            e = i(Math.abs(this), b, a.CurrencyGroupSizes, a.CurrencyGroupSeparator, a.CurrencyDecimalSeparator); break;
        case "n":
        case "N":
            if (this < 0) c = p[a.NumberNegativePattern];
            else c = "n"; if (b === -1) b = a.NumberDecimalDigits;
            e = i(Math.abs(this), b, a.NumberGroupSizes, a.NumberGroupSeparator, a.NumberDecimalSeparator); break;
        case "p":
        case "P":
            if (this < 0) c = n[a.PercentNegativePattern];
            else c = o[a.PercentPositivePattern]; if (b === -1) b = a.PercentDecimalDigits;
            e = i(Math.abs(this) * 100, b, a.PercentGroupSizes, a.PercentGroupSeparator, a.PercentDecimalSeparator); break;
        default:
            throw Error.format(Sys.Res.formatBadFormatSpecifier) } var k = /n|\$|-|%/g,
        f = ""; for (; true;) { var q = k.lastIndex,
            h = k.exec(c);
        f += c.slice(q, h ? h.index : c.length); if (!h) break; switch (h[0]) {
            case "n":
                f += e; break;
            case "$":
                f += a.CurrencySymbol; break;
            case "-":
                f += a.NegativeSign; break;
            case "%":
                f += a.PercentSymbol } } return f };
RegExp.__typeName = "RegExp";
RegExp.__class = true;
Array.__typeName = "Array";
Array.__class = true;
Array.add = Array.enqueue = function(a, b) { a[a.length] = b };
Array.addRange = function(a, b) { a.push.apply(a, b) };
Array.clear = function(a) { a.length = 0 };
Array.clone = function(a) { if (a.length === 1) return [a[0]];
    else return Array.apply(null, a) };
Array.contains = function(a, b) { return Array.indexOf(a, b) >= 0 };
Array.dequeue = function(a) { return a.shift() };
Array.forEach = function(b, e, d) { for (var a = 0, f = b.length; a < f; a++) { var c = b[a]; if (typeof c !== "undefined") e.call(d, c, a, b) } };
Array.indexOf = function(d, e, a) { if (typeof e === "undefined") return -1; var c = d.length; if (c !== 0) { a = a - 0; if (isNaN(a)) a = 0;
        else { if (isFinite(a)) a = a - a % 1; if (a < 0) a = Math.max(0, c + a) } for (var b = a; b < c; b++)
            if (typeof d[b] !== "undefined" && d[b] === e) return b } return -1 };
Array.insert = function(a, b, c) { a.splice(b, 0, c) };
Array.parse = function(value) { if (!value) return []; return eval(value) };
Array.remove = function(b, c) { var a = Array.indexOf(b, c); if (a >= 0) b.splice(a, 1); return a >= 0 };
Array.removeAt = function(a, b) { a.splice(b, 1) };
if (!window) this.window = this;
window.Type = Function;
Type.prototype.callBaseMethod = function(a, d, b) { var c = this.getBaseMethod(a, d); if (!b) return c.apply(a);
    else return c.apply(a, b) };
Type.prototype.getBaseMethod = function(d, c) { var b = this.getBaseType(); if (b) { var a = b.prototype[c]; return a instanceof Function ? a : null } return null };
Type.prototype.getBaseType = function() { return typeof this.__baseType === "undefined" ? null : this.__baseType };
Type.prototype.getInterfaces = function() { var a = [],
        b = this; while (b) { var c = b.__interfaces; if (c)
            for (var d = 0, f = c.length; d < f; d++) { var e = c[d]; if (!Array.contains(a, e)) a[a.length] = e } b = b.__baseType } return a };
Type.prototype.getName = function() { return typeof this.__typeName === "undefined" ? "" : this.__typeName };
Type.prototype.implementsInterface = function(d) { this.resolveInheritance(); var c = d.getName(),
        a = this.__interfaceCache; if (a) { var e = a[c]; if (typeof e !== "undefined") return e } else a = this.__interfaceCache = {}; var b = this; while (b) { var f = b.__interfaces; if (f)
            if (Array.indexOf(f, d) !== -1) return a[c] = true;
        b = b.__baseType } return a[c] = false };
Type.prototype.inheritsFrom = function(b) { this.resolveInheritance(); var a = this.__baseType; while (a) { if (a === b) return true;
        a = a.__baseType } return false };
Type.prototype.initializeBase = function(a, b) { this.resolveInheritance(); if (this.__baseType)
        if (!b) this.__baseType.apply(a);
        else this.__baseType.apply(a, b); return a };
Type.prototype.isImplementedBy = function(a) { if (typeof a === "undefined" || a === null) return false; var b = Object.getType(a); return !!(b.implementsInterface && b.implementsInterface(this)) };
Type.prototype.isInstanceOfType = function(b) { if (typeof b === "undefined" || b === null) return false; if (b instanceof this) return true; var a = Object.getType(b); return !!(a === this) || a.inheritsFrom && a.inheritsFrom(this) || a.implementsInterface && a.implementsInterface(this) };
Type.prototype.registerClass = function(c, b, d) { this.prototype.constructor = this;
    this.__typeName = c;
    this.__class = true; if (b) { this.__baseType = b;
        this.__basePrototypePending = true } Sys.__upperCaseTypes[c.toUpperCase()] = this; if (d) { this.__interfaces = []; for (var a = 2, f = arguments.length; a < f; a++) { var e = arguments[a];
            this.__interfaces.push(e) } } return this };
Type.prototype.registerInterface = function(a) { Sys.__upperCaseTypes[a.toUpperCase()] = this;
    this.prototype.constructor = this;
    this.__typeName = a;
    this.__interface = true; return this };
Type.prototype.resolveInheritance = function() { if (this.__basePrototypePending) { var b = this.__baseType;
        b.resolveInheritance(); for (var a in b.prototype) { var c = b.prototype[a]; if (!this.prototype[a]) this.prototype[a] = c } delete this.__basePrototypePending } };
Type.getRootNamespaces = function() { return Array.clone(Sys.__rootNamespaces) };
Type.isClass = function(a) { if (typeof a === "undefined" || a === null) return false; return !!a.__class };
Type.isInterface = function(a) { if (typeof a === "undefined" || a === null) return false; return !!a.__interface };
Type.isNamespace = function(a) { if (typeof a === "undefined" || a === null) return false; return !!a.__namespace };
Type.parse = function(typeName, ns) { var fn; if (ns) { fn = Sys.__upperCaseTypes[ns.getName().toUpperCase() + "." + typeName.toUpperCase()]; return fn || null } if (!typeName) return null; if (!Type.__htClasses) Type.__htClasses = {};
    fn = Type.__htClasses[typeName]; if (!fn) { fn = eval(typeName);
        Type.__htClasses[typeName] = fn } return fn };
Type.registerNamespace = function(f) { var d = window,
        c = f.split("."); for (var b = 0; b < c.length; b++) { var e = c[b],
            a = d[e]; if (!a) { a = d[e] = { __namespace: true, __typeName: c.slice(0, b + 1).join(".") }; if (b === 0) Sys.__rootNamespaces[Sys.__rootNamespaces.length] = a;
            a.getName = function() { return this.__typeName } } d = a } };
window.Sys = { __namespace: true, __typeName: "Sys", getName: function() { return "Sys" }, __upperCaseTypes: {} };
Sys.__rootNamespaces = [Sys];
Sys.IDisposable = function() {};
Sys.IDisposable.prototype = {};
Sys.IDisposable.registerInterface("Sys.IDisposable");
Sys.StringBuilder = function(a) { this._parts = typeof a !== "undefined" && a !== null && a !== "" ? [a.toString()] : [];
    this._value = {};
    this._len = 0 };
Sys.StringBuilder.prototype = { append: function(a) { this._parts[this._parts.length] = a }, appendLine: function(a) { this._parts[this._parts.length] = typeof a === "undefined" || a === null || a === "" ? "\r\n" : a + "\r\n" }, clear: function() { this._parts = [];
        this._value = {};
        this._len = 0 }, isEmpty: function() { if (this._parts.length === 0) return true; return this.toString() === "" }, toString: function(a) { a = a || ""; var b = this._parts; if (this._len !== b.length) { this._value = {};
            this._len = b.length } var d = this._value; if (typeof d[a] === "undefined") { if (a !== "")
                for (var c = 0; c < b.length;)
                    if (typeof b[c] === "undefined" || b[c] === "" || b[c] === null) b.splice(c, 1);
                    else c++;
            d[a] = this._parts.join(a) } return d[a] } };
Sys.StringBuilder.registerClass("Sys.StringBuilder");
if (!window.XMLHttpRequest) window.XMLHttpRequest = function() { var b = ["Msxml2.XMLHTTP.3.0", "Msxml2.XMLHTTP"]; for (var a = 0, c = b.length; a < c; a++) try { return new ActiveXObject(b[a]) } catch (d) {}
    return null };
Sys.Browser = {};
Sys.Browser.InternetExplorer = {};
Sys.Browser.Firefox = {};
Sys.Browser.Safari = {};
Sys.Browser.Opera = {};
Sys.Browser.agent = null;
Sys.Browser.hasDebuggerStatement = false;
Sys.Browser.name = navigator.appName;
Sys.Browser.version = parseFloat(navigator.appVersion);
Sys.Browser.documentMode = 0;
if (navigator.userAgent.indexOf(" MSIE ") > -1) { Sys.Browser.agent = Sys.Browser.InternetExplorer;
    Sys.Browser.version = parseFloat(navigator.userAgent.match(/MSIE (\d+\.\d+)/)[1]); if (Sys.Browser.version >= 8)
        if (document.documentMode >= 7) Sys.Browser.documentMode = document.documentMode;
    Sys.Browser.hasDebuggerStatement = true } else if (navigator.userAgent.indexOf(" Firefox/") > -1) { Sys.Browser.agent = Sys.Browser.Firefox;
    Sys.Browser.version = parseFloat(navigator.userAgent.match(/Firefox\/(\d+\.\d+)/)[1]);
    Sys.Browser.name = "Firefox";
    Sys.Browser.hasDebuggerStatement = true } else if (navigator.userAgent.indexOf(" AppleWebKit/") > -1) { Sys.Browser.agent = Sys.Browser.Safari;
    Sys.Browser.version = parseFloat(navigator.userAgent.match(/AppleWebKit\/(\d+(\.\d+)?)/)[1]);
    Sys.Browser.name = "Safari" } else if (navigator.userAgent.indexOf("Opera/") > -1) Sys.Browser.agent = Sys.Browser.Opera;
Type.registerNamespace("Sys.UI");
Sys._Debug = function() {};
Sys._Debug.prototype = { _appendConsole: function(a) { if (typeof Debug !== "undefined" && Debug.writeln) Debug.writeln(a); if (window.console && window.console.log) window.console.log(a); if (window.opera) window.opera.postError(a); if (window.debugService) window.debugService.trace(a) }, _appendTrace: function(b) { var a = document.getElementById("TraceConsole"); if (a && a.tagName.toUpperCase() === "TEXTAREA") a.value += b + "\n" }, assert: function(c, a, b) { if (!c) { a = b && this.assert.caller ? String.format(Sys.Res.assertFailedCaller, a, this.assert.caller) : String.format(Sys.Res.assertFailed, a); if (confirm(String.format(Sys.Res.breakIntoDebugger, a))) this.fail(a) } }, clearTrace: function() { var a = document.getElementById("TraceConsole"); if (a && a.tagName.toUpperCase() === "TEXTAREA") a.value = "" }, fail: function(message) { this._appendConsole(message); if (Sys.Browser.hasDebuggerStatement) eval("debugger") }, trace: function(a) { this._appendConsole(a);
        this._appendTrace(a) }, traceDump: function(a, b) { var c = this._traceDump(a, b, true) }, _traceDump: function(a, c, f, b, d) { c = c ? c : "traceDump";
        b = b ? b : ""; if (a === null) { this.trace(b + c + ": null"); return } switch (typeof a) {
            case "undefined":
                this.trace(b + c + ": Undefined"); break;
            case "number":
            case "string":
            case "boolean":
                this.trace(b + c + ": " + a); break;
            default:
                if (Date.isInstanceOfType(a) || RegExp.isInstanceOfType(a)) { this.trace(b + c + ": " + a.toString()); break } if (!d) d = [];
                else if (Array.contains(d, a)) { this.trace(b + c + ": ..."); return } Array.add(d, a); if (a == window || a === document || window.HTMLElement && a instanceof HTMLElement || typeof a.nodeName === "string") { var k = a.tagName ? a.tagName : "DomElement"; if (a.id) k += " - " + a.id;
                    this.trace(b + c + " {" + k + "}") } else { var i = Object.getTypeName(a);
                    this.trace(b + c + (typeof i === "string" ? " {" + i + "}" : "")); if (b === "" || f) { b += "    "; var e, j, l, g, h; if (Array.isInstanceOfType(a)) { j = a.length; for (e = 0; e < j; e++) this._traceDump(a[e], "[" + e + "]", f, b, d) } else
                            for (g in a) { h = a[g]; if (!Function.isInstanceOfType(h)) this._traceDump(h, g, f, b, d) } } } Array.remove(d, a) } } };
Sys._Debug.registerClass("Sys._Debug");
Sys.Debug = new Sys._Debug;
Sys.Debug.isDebug = false;

function Sys$Enum$parse(c, e) { var a, b, i; if (e) { a = this.__lowerCaseValues; if (!a) { this.__lowerCaseValues = a = {}; var g = this.prototype; for (var f in g) a[f.toLowerCase()] = g[f] } } else a = this.prototype; if (!this.__flags) { i = e ? c.toLowerCase() : c;
        b = a[i.trim()]; if (typeof b !== "number") throw Error.argument("value", String.format(Sys.Res.enumInvalidValue, c, this.__typeName)); return b } else { var h = (e ? c.toLowerCase() : c).split(","),
            j = 0; for (var d = h.length - 1; d >= 0; d--) { var k = h[d].trim();
            b = a[k]; if (typeof b !== "number") throw Error.argument("value", String.format(Sys.Res.enumInvalidValue, c.split(",")[d].trim(), this.__typeName));
            j |= b } return j } }

function Sys$Enum$toString(c) { if (typeof c === "undefined" || c === null) return this.__string; var d = this.prototype,
        a; if (!this.__flags || c === 0) { for (a in d)
            if (d[a] === c) return a } else { var b = this.__sortedValues; if (!b) { b = []; for (a in d) b[b.length] = { key: a, value: d[a] };
            b.sort(function(a, b) { return a.value - b.value });
            this.__sortedValues = b } var e = [],
            g = c; for (a = b.length - 1; a >= 0; a--) { var h = b[a],
                f = h.value; if (f === 0) continue; if ((f & c) === f) { e[e.length] = h.key;
                g -= f; if (g === 0) break } } if (e.length && g === 0) return e.reverse().join(", ") } return "" } Type.prototype.registerEnum = function(b, c) { Sys.__upperCaseTypes[b.toUpperCase()] = this; for (var a in this.prototype) this[a] = this.prototype[a];
    this.__typeName = b;
    this.parse = Sys$Enum$parse;
    this.__string = this.toString();
    this.toString = Sys$Enum$toString;
    this.__flags = c;
    this.__enum = true };
Type.isEnum = function(a) { if (typeof a === "undefined" || a === null) return false; return !!a.__enum };
Type.isFlags = function(a) { if (typeof a === "undefined" || a === null) return false; return !!a.__flags };
Sys.EventHandlerList = function() { this._list = {} };
Sys.EventHandlerList.prototype = { addHandler: function(b, a) { Array.add(this._getEvent(b, true), a) }, removeHandler: function(c, b) { var a = this._getEvent(c); if (!a) return;
        Array.remove(a, b) }, getHandler: function(b) { var a = this._getEvent(b); if (!a || a.length === 0) return null;
        a = Array.clone(a); return function(c, d) { for (var b = 0, e = a.length; b < e; b++) a[b](c, d) } }, _getEvent: function(a, b) { if (!this._list[a]) { if (!b) return null;
            this._list[a] = [] } return this._list[a] } };
Sys.EventHandlerList.registerClass("Sys.EventHandlerList");
Sys.EventArgs = function() {};
Sys.EventArgs.registerClass("Sys.EventArgs");
Sys.EventArgs.Empty = new Sys.EventArgs;
Sys.CancelEventArgs = function() { Sys.CancelEventArgs.initializeBase(this);
    this._cancel = false };
Sys.CancelEventArgs.prototype = { get_cancel: function() { return this._cancel }, set_cancel: function(a) { this._cancel = a } };
Sys.CancelEventArgs.registerClass("Sys.CancelEventArgs", Sys.EventArgs);
Sys.INotifyPropertyChange = function() {};
Sys.INotifyPropertyChange.prototype = {};
Sys.INotifyPropertyChange.registerInterface("Sys.INotifyPropertyChange");
Sys.PropertyChangedEventArgs = function(a) { Sys.PropertyChangedEventArgs.initializeBase(this);
    this._propertyName = a };
Sys.PropertyChangedEventArgs.prototype = { get_propertyName: function() { return this._propertyName } };
Sys.PropertyChangedEventArgs.registerClass("Sys.PropertyChangedEventArgs", Sys.EventArgs);
Sys.INotifyDisposing = function() {};
Sys.INotifyDisposing.prototype = {};
Sys.INotifyDisposing.registerInterface("Sys.INotifyDisposing");
Sys.Component = function() { if (Sys.Application) Sys.Application.registerDisposableObject(this) };
Sys.Component.prototype = { _id: null, _initialized: false, _updating: false, get_events: function() { if (!this._events) this._events = new Sys.EventHandlerList; return this._events }, get_id: function() { return this._id }, set_id: function(a) { this._id = a }, get_isInitialized: function() { return this._initialized }, get_isUpdating: function() { return this._updating }, add_disposing: function(a) { this.get_events().addHandler("disposing", a) }, remove_disposing: function(a) { this.get_events().removeHandler("disposing", a) }, add_propertyChanged: function(a) { this.get_events().addHandler("propertyChanged", a) }, remove_propertyChanged: function(a) { this.get_events().removeHandler("propertyChanged", a) }, beginUpdate: function() { this._updating = true }, dispose: function() { if (this._events) { var a = this._events.getHandler("disposing"); if (a) a(this, Sys.EventArgs.Empty) } delete this._events;
        Sys.Application.unregisterDisposableObject(this);
        Sys.Application.removeComponent(this) }, endUpdate: function() { this._updating = false; if (!this._initialized) this.initialize();
        this.updated() }, initialize: function() { this._initialized = true }, raisePropertyChanged: function(b) { if (!this._events) return; var a = this._events.getHandler("propertyChanged"); if (a) a(this, new Sys.PropertyChangedEventArgs(b)) }, updated: function() {} };
Sys.Component.registerClass("Sys.Component", null, Sys.IDisposable, Sys.INotifyPropertyChange, Sys.INotifyDisposing);

function Sys$Component$_setProperties(a, i) { var d, j = Object.getType(a),
        e = j === Object || j === Sys.UI.DomElement,
        h = Sys.Component.isInstanceOfType(a) && !a.get_isUpdating(); if (h) a.beginUpdate(); for (var c in i) { var b = i[c],
            f = e ? null : a["get_" + c]; if (e || typeof f !== "function") { var k = a[c]; if (!b || typeof b !== "object" || e && !k) a[c] = b;
            else Sys$Component$_setProperties(k, b) } else { var l = a["set_" + c]; if (typeof l === "function") l.apply(a, [b]);
            else if (b instanceof Array) { d = f.apply(a); for (var g = 0, m = d.length, n = b.length; g < n; g++, m++) d[m] = b[g] } else if (typeof b === "object" && Object.getType(b) === Object) { d = f.apply(a);
                Sys$Component$_setProperties(d, b) } } } if (h) a.endUpdate() }

function Sys$Component$_setReferences(c, b) { for (var a in b) { var e = c["set_" + a],
            d = $find(b[a]);
        e.apply(c, [d]) } }
var $create = Sys.Component.create = function(h, f, d, c, g) { var a = g ? new h(g) : new h,
        b = Sys.Application,
        i = b.get_isCreatingComponents();
    a.beginUpdate(); if (f) Sys$Component$_setProperties(a, f); if (d)
        for (var e in d) a["add_" + e](d[e]); if (a.get_id()) b.addComponent(a); if (i) { b._createdComponents[b._createdComponents.length] = a; if (c) b._addComponentToSecondPass(a, c);
        else a.endUpdate() } else { if (c) Sys$Component$_setReferences(a, c);
        a.endUpdate() } return a };
Sys.UI.MouseButton = function() { throw Error.notImplemented() };
Sys.UI.MouseButton.prototype = { leftButton: 0, middleButton: 1, rightButton: 2 };
Sys.UI.MouseButton.registerEnum("Sys.UI.MouseButton");
Sys.UI.Key = function() { throw Error.notImplemented() };
Sys.UI.Key.prototype = { backspace: 8, tab: 9, enter: 13, esc: 27, space: 32, pageUp: 33, pageDown: 34, end: 35, home: 36, left: 37, up: 38, right: 39, down: 40, del: 127 };
Sys.UI.Key.registerEnum("Sys.UI.Key");
Sys.UI.Point = function(a, b) { this.x = a;
    this.y = b };
Sys.UI.Point.registerClass("Sys.UI.Point");
Sys.UI.Bounds = function(c, d, b, a) { this.x = c;
    this.y = d;
    this.height = a;
    this.width = b };
Sys.UI.Bounds.registerClass("Sys.UI.Bounds");
Sys.UI.DomEvent = function(e) { var a = e,
        b = this.type = a.type.toLowerCase();
    this.rawEvent = a;
    this.altKey = a.altKey; if (typeof a.button !== "undefined") this.button = typeof a.which !== "undefined" ? a.button : a.button === 4 ? Sys.UI.MouseButton.middleButton : a.button === 2 ? Sys.UI.MouseButton.rightButton : Sys.UI.MouseButton.leftButton; if (b === "keypress") this.charCode = a.charCode || a.keyCode;
    else if (a.keyCode && a.keyCode === 46) this.keyCode = 127;
    else this.keyCode = a.keyCode;
    this.clientX = a.clientX;
    this.clientY = a.clientY;
    this.ctrlKey = a.ctrlKey;
    this.target = a.target ? a.target : a.srcElement; if (!b.startsWith("key"))
        if (typeof a.offsetX !== "undefined" && typeof a.offsetY !== "undefined") { this.offsetX = a.offsetX;
            this.offsetY = a.offsetY } else if (this.target && this.target.nodeType !== 3 && typeof a.clientX === "number") { var c = Sys.UI.DomElement.getLocation(this.target),
            d = Sys.UI.DomElement._getWindow(this.target);
        this.offsetX = (d.pageXOffset || 0) + a.clientX - c.x;
        this.offsetY = (d.pageYOffset || 0) + a.clientY - c.y } this.screenX = a.screenX;
    this.screenY = a.screenY;
    this.shiftKey = a.shiftKey };
Sys.UI.DomEvent.prototype = { preventDefault: function() { if (this.rawEvent.preventDefault) this.rawEvent.preventDefault();
        else if (window.event) this.rawEvent.returnValue = false }, stopPropagation: function() { if (this.rawEvent.stopPropagation) this.rawEvent.stopPropagation();
        else if (window.event) this.rawEvent.cancelBubble = true } };
Sys.UI.DomEvent.registerClass("Sys.UI.DomEvent");
var $addHandler = Sys.UI.DomEvent.addHandler = function(a, d, e) { if (!a._events) a._events = {}; var c = a._events[d]; if (!c) a._events[d] = c = []; var b; if (a.addEventListener) { b = function(b) { return e.call(a, new Sys.UI.DomEvent(b)) };
            a.addEventListener(d, b, false) } else if (a.attachEvent) { b = function() { var b = {}; try { b = Sys.UI.DomElement._getWindow(a).event } catch (c) {} return e.call(a, new Sys.UI.DomEvent(b)) };
            a.attachEvent("on" + d, b) } c[c.length] = { handler: e, browserHandler: b } },
    $addHandlers = Sys.UI.DomEvent.addHandlers = function(e, d, c) { for (var b in d) { var a = d[b]; if (c) a = Function.createDelegate(c, a);
            $addHandler(e, b, a) } },
    $clearHandlers = Sys.UI.DomEvent.clearHandlers = function(a) { if (a._events) { var e = a._events; for (var b in e) { var d = e[b]; for (var c = d.length - 1; c >= 0; c--) $removeHandler(a, b, d[c].handler) } a._events = null } },
    $removeHandler = Sys.UI.DomEvent.removeHandler = function(a, e, f) { var d = null,
            c = a._events[e]; for (var b = 0, g = c.length; b < g; b++)
            if (c[b].handler === f) { d = c[b].browserHandler; break }
        if (a.removeEventListener) a.removeEventListener(e, d, false);
        else if (a.detachEvent) a.detachEvent("on" + e, d);
        c.splice(b, 1) };
Sys.UI.DomElement = function() {};
Sys.UI.DomElement.registerClass("Sys.UI.DomElement");
Sys.UI.DomElement.addCssClass = function(a, b) { if (!Sys.UI.DomElement.containsCssClass(a, b))
        if (a.className === "") a.className = b;
        else a.className += " " + b };
Sys.UI.DomElement.containsCssClass = function(b, a) { return Array.contains(b.className.split(" "), a) };
Sys.UI.DomElement.getBounds = function(a) { var b = Sys.UI.DomElement.getLocation(a); return new Sys.UI.Bounds(b.x, b.y, a.offsetWidth || 0, a.offsetHeight || 0) };
var $get = Sys.UI.DomElement.getElementById = function(f, e) { if (!e) return document.getElementById(f); if (e.getElementById) return e.getElementById(f); var c = [],
        d = e.childNodes; for (var b = 0; b < d.length; b++) { var a = d[b]; if (a.nodeType == 1) c[c.length] = a } while (c.length) { a = c.shift(); if (a.id == f) return a;
        d = a.childNodes; for (b = 0; b < d.length; b++) { a = d[b]; if (a.nodeType == 1) c[c.length] = a } } return null };
switch (Sys.Browser.agent) {
    case Sys.Browser.InternetExplorer:
        Sys.UI.DomElement.getLocation = function(a) { if (a.self || a.nodeType === 9) return new Sys.UI.Point(0, 0); var b = a.getBoundingClientRect(); if (!b) return new Sys.UI.Point(0, 0); var d = a.ownerDocument.documentElement,
                e = b.left - 2 + d.scrollLeft,
                f = b.top - 2 + d.scrollTop; try { var c = a.ownerDocument.parentWindow.frameElement || null; if (c) { var g = c.frameBorder === "0" || c.frameBorder === "no" ? 2 : 0;
                    e += g;
                    f += g } } catch (h) {} return new Sys.UI.Point(e, f) }; break;
    case Sys.Browser.Safari:
        Sys.UI.DomElement.getLocation = function(c) { if (c.window && c.window === c || c.nodeType === 9) return new Sys.UI.Point(0, 0); var f = 0,
                g = 0,
                j = null,
                e = null,
                b; for (var a = c; a; j = a, (e = b, a = a.offsetParent)) { b = Sys.UI.DomElement._getCurrentStyle(a); var d = a.tagName ? a.tagName.toUpperCase() : null; if ((a.offsetLeft || a.offsetTop) && (d !== "BODY" || (!e || e.position !== "absolute"))) { f += a.offsetLeft;
                    g += a.offsetTop } } b = Sys.UI.DomElement._getCurrentStyle(c); var h = b ? b.position : null; if (!h || h !== "absolute")
                for (var a = c.parentNode; a; a = a.parentNode) { d = a.tagName ? a.tagName.toUpperCase() : null; if (d !== "BODY" && d !== "HTML" && (a.scrollLeft || a.scrollTop)) { f -= a.scrollLeft || 0;
                        g -= a.scrollTop || 0 } b = Sys.UI.DomElement._getCurrentStyle(a); var i = b ? b.position : null; if (i && i === "absolute") break }
            return new Sys.UI.Point(f, g) }; break;
    case Sys.Browser.Opera:
        Sys.UI.DomElement.getLocation = function(b) { if (b.window && b.window === b || b.nodeType === 9) return new Sys.UI.Point(0, 0); var d = 0,
                e = 0,
                i = null; for (var a = b; a; i = a, a = a.offsetParent) { var f = a.tagName;
                d += a.offsetLeft || 0;
                e += a.offsetTop || 0 } var g = b.style.position,
                c = g && g !== "static"; for (var a = b.parentNode; a; a = a.parentNode) { f = a.tagName ? a.tagName.toUpperCase() : null; if (f !== "BODY" && f !== "HTML" && (a.scrollLeft || a.scrollTop) && (c && (a.style.overflow === "scroll" || a.style.overflow === "auto"))) { d -= a.scrollLeft || 0;
                    e -= a.scrollTop || 0 } var h = a && a.style ? a.style.position : null;
                c = c || h && h !== "static" } return new Sys.UI.Point(d, e) }; break;
    default:
        Sys.UI.DomElement.getLocation = function(d) { if (d.window && d.window === d || d.nodeType === 9) return new Sys.UI.Point(0, 0); var e = 0,
                f = 0,
                i = null,
                g = null,
                b = null; for (var a = d; a; i = a, (g = b, a = a.offsetParent)) { var c = a.tagName ? a.tagName.toUpperCase() : null;
                b = Sys.UI.DomElement._getCurrentStyle(a); if ((a.offsetLeft || a.offsetTop) && !(c === "BODY" && (!g || g.position !== "absolute"))) { e += a.offsetLeft;
                    f += a.offsetTop } if (i !== null && b) { if (c !== "TABLE" && c !== "TD" && c !== "HTML") { e += parseInt(b.borderLeftWidth) || 0;
                        f += parseInt(b.borderTopWidth) || 0 } if (c === "TABLE" && (b.position === "relative" || b.position === "absolute")) { e += parseInt(b.marginLeft) || 0;
                        f += parseInt(b.marginTop) || 0 } } } b = Sys.UI.DomElement._getCurrentStyle(d); var h = b ? b.position : null; if (!h || h !== "absolute")
                for (var a = d.parentNode; a; a = a.parentNode) { c = a.tagName ? a.tagName.toUpperCase() : null; if (c !== "BODY" && c !== "HTML" && (a.scrollLeft || a.scrollTop)) { e -= a.scrollLeft || 0;
                        f -= a.scrollTop || 0;
                        b = Sys.UI.DomElement._getCurrentStyle(a); if (b) { e += parseInt(b.borderLeftWidth) || 0;
                            f += parseInt(b.borderTopWidth) || 0 } } }
            return new Sys.UI.Point(e, f) } } Sys.UI.DomElement.removeCssClass = function(d, c) { var a = " " + d.className + " ",
        b = a.indexOf(" " + c + " "); if (b >= 0) d.className = (a.substr(0, b) + " " + a.substring(b + c.length + 1, a.length)).trim() };
Sys.UI.DomElement.setLocation = function(b, c, d) { var a = b.style;
    a.position = "absolute";
    a.left = c + "px";
    a.top = d + "px" };
Sys.UI.DomElement.toggleCssClass = function(b, a) { if (Sys.UI.DomElement.containsCssClass(b, a)) Sys.UI.DomElement.removeCssClass(b, a);
    else Sys.UI.DomElement.addCssClass(b, a) };
Sys.UI.DomElement.getVisibilityMode = function(a) { return a._visibilityMode === Sys.UI.VisibilityMode.hide ? Sys.UI.VisibilityMode.hide : Sys.UI.VisibilityMode.collapse };
Sys.UI.DomElement.setVisibilityMode = function(a, b) { Sys.UI.DomElement._ensureOldDisplayMode(a); if (a._visibilityMode !== b) { a._visibilityMode = b; if (Sys.UI.DomElement.getVisible(a) === false)
            if (a._visibilityMode === Sys.UI.VisibilityMode.hide) a.style.display = a._oldDisplayMode;
            else a.style.display = "none";
        a._visibilityMode = b } };
Sys.UI.DomElement.getVisible = function(b) { var a = b.currentStyle || Sys.UI.DomElement._getCurrentStyle(b); if (!a) return true; return a.visibility !== "hidden" && a.display !== "none" };
Sys.UI.DomElement.setVisible = function(a, b) { if (b !== Sys.UI.DomElement.getVisible(a)) { Sys.UI.DomElement._ensureOldDisplayMode(a);
        a.style.visibility = b ? "visible" : "hidden"; if (b || a._visibilityMode === Sys.UI.VisibilityMode.hide) a.style.display = a._oldDisplayMode;
        else a.style.display = "none" } };
Sys.UI.DomElement._ensureOldDisplayMode = function(a) { if (!a._oldDisplayMode) { var b = a.currentStyle || Sys.UI.DomElement._getCurrentStyle(a);
        a._oldDisplayMode = b ? b.display : null; if (!a._oldDisplayMode || a._oldDisplayMode === "none") switch (a.tagName.toUpperCase()) {
            case "DIV":
            case "P":
            case "ADDRESS":
            case "BLOCKQUOTE":
            case "BODY":
            case "COL":
            case "COLGROUP":
            case "DD":
            case "DL":
            case "DT":
            case "FIELDSET":
            case "FORM":
            case "H1":
            case "H2":
            case "H3":
            case "H4":
            case "H5":
            case "H6":
            case "HR":
            case "IFRAME":
            case "LEGEND":
            case "OL":
            case "PRE":
            case "TABLE":
            case "TD":
            case "TH":
            case "TR":
            case "UL":
                a._oldDisplayMode = "block"; break;
            case "LI":
                a._oldDisplayMode = "list-item"; break;
            default:
                a._oldDisplayMode = "inline" } } };
Sys.UI.DomElement._getWindow = function(a) { var b = a.ownerDocument || a.document || a; return b.defaultView || b.parentWindow };
Sys.UI.DomElement._getCurrentStyle = function(a) { if (a.nodeType === 3) return null; var c = Sys.UI.DomElement._getWindow(a); if (a.documentElement) a = a.documentElement; var b = c && a !== c && c.getComputedStyle ? c.getComputedStyle(a, null) : a.currentStyle || a.style; if (!b && Sys.Browser.agent === Sys.Browser.Safari && a.style) { var g = a.style.display,
            f = a.style.position;
        a.style.position = "absolute";
        a.style.display = "block"; var e = c.getComputedStyle(a, null);
        a.style.display = g;
        a.style.position = f;
        b = {}; for (var d in e) b[d] = e[d];
        b.display = "none" } return b };
Sys.IContainer = function() {};
Sys.IContainer.prototype = {};
Sys.IContainer.registerInterface("Sys.IContainer");
Sys._ScriptLoader = function() { this._scriptsToLoad = null;
    this._sessions = [];
    this._scriptLoadedDelegate = Function.createDelegate(this, this._scriptLoadedHandler) };
Sys._ScriptLoader.prototype = { dispose: function() { this._stopSession();
        this._loading = false; if (this._events) delete this._events;
        this._sessions = null;
        this._currentSession = null;
        this._scriptLoadedDelegate = null }, loadScripts: function(d, b, c, a) { var e = { allScriptsLoadedCallback: b, scriptLoadFailedCallback: c, scriptLoadTimeoutCallback: a, scriptsToLoad: this._scriptsToLoad, scriptTimeout: d };
        this._scriptsToLoad = null;
        this._sessions[this._sessions.length] = e; if (!this._loading) this._nextSession() }, notifyScriptLoaded: function() { if (!this._loading) return;
        this._currentTask._notified++; if (Sys.Browser.agent === Sys.Browser.Safari)
            if (this._currentTask._notified === 1) window.setTimeout(Function.createDelegate(this, function() { this._scriptLoadedHandler(this._currentTask.get_scriptElement(), true) }), 0) }, queueCustomScriptTag: function(a) { if (!this._scriptsToLoad) this._scriptsToLoad = [];
        Array.add(this._scriptsToLoad, a) }, queueScriptBlock: function(a) { if (!this._scriptsToLoad) this._scriptsToLoad = [];
        Array.add(this._scriptsToLoad, { text: a }) }, queueScriptReference: function(a) { if (!this._scriptsToLoad) this._scriptsToLoad = [];
        Array.add(this._scriptsToLoad, { src: a }) }, _createScriptElement: function(c) { var a = document.createElement("script");
        a.type = "text/javascript"; for (var b in c) a[b] = c[b]; return a }, _loadScriptsInternal: function() { var b = this._currentSession; if (b.scriptsToLoad && b.scriptsToLoad.length > 0) { var c = Array.dequeue(b.scriptsToLoad),
                a = this._createScriptElement(c); if (a.text && Sys.Browser.agent === Sys.Browser.Safari) { a.innerHTML = a.text;
                delete a.text } if (typeof c.src === "string") { this._currentTask = new Sys._ScriptLoaderTask(a, this._scriptLoadedDelegate);
                this._currentTask.execute() } else { document.getElementsByTagName("head")[0].appendChild(a);
                Sys._ScriptLoader._clearScript(a);
                this._loadScriptsInternal() } } else { this._stopSession(); var d = b.allScriptsLoadedCallback; if (d) d(this);
            this._nextSession() } }, _nextSession: function() { if (this._sessions.length === 0) { this._loading = false;
            this._currentSession = null; return } this._loading = true; var a = Array.dequeue(this._sessions);
        this._currentSession = a; if (a.scriptTimeout > 0) this._timeoutCookie = window.setTimeout(Function.createDelegate(this, this._scriptLoadTimeoutHandler), a.scriptTimeout * 1000);
        this._loadScriptsInternal() }, _raiseError: function(a) { var c = this._currentSession.scriptLoadFailedCallback,
            b = this._currentTask.get_scriptElement();
        this._stopSession(); if (c) { c(this, b, a);
            this._nextSession() } else { this._loading = false; throw Sys._ScriptLoader._errorScriptLoadFailed(b.src, a) } }, _scriptLoadedHandler: function(a, b) { if (b && this._currentTask._notified)
            if (this._currentTask._notified > 1) this._raiseError(true);
            else { Array.add(Sys._ScriptLoader._getLoadedScripts(), a.src);
                this._currentTask.dispose();
                this._currentTask = null;
                this._loadScriptsInternal() } else this._raiseError(false) }, _scriptLoadTimeoutHandler: function() { var a = this._currentSession.scriptLoadTimeoutCallback;
        this._stopSession(); if (a) a(this);
        this._nextSession() }, _stopSession: function() { if (this._timeoutCookie) { window.clearTimeout(this._timeoutCookie);
            this._timeoutCookie = null } if (this._currentTask) { this._currentTask.dispose();
            this._currentTask = null } } };
Sys._ScriptLoader.registerClass("Sys._ScriptLoader", null, Sys.IDisposable);
Sys._ScriptLoader.getInstance = function() { var a = Sys._ScriptLoader._activeInstance; if (!a) a = Sys._ScriptLoader._activeInstance = new Sys._ScriptLoader; return a };
Sys._ScriptLoader.isScriptLoaded = function(b) { var a = document.createElement("script");
    a.src = b; return Array.contains(Sys._ScriptLoader._getLoadedScripts(), a.src) };
Sys._ScriptLoader.readLoadedScripts = function() { if (!Sys._ScriptLoader._referencedScripts) { var b = Sys._ScriptLoader._referencedScripts = [],
            c = document.getElementsByTagName("script"); for (i = c.length - 1; i >= 0; i--) { var d = c[i],
                a = d.src; if (a.length)
                if (!Array.contains(b, a)) Array.add(b, a) } } };
Sys._ScriptLoader._clearScript = function(a) { if (!Sys.Debug.isDebug) a.parentNode.removeChild(a) };
Sys._ScriptLoader._errorScriptLoadFailed = function(b, d) { var a; if (d) a = Sys.Res.scriptLoadMultipleCallbacks;
    else a = Sys.Res.scriptLoadFailed; var e = "Sys.ScriptLoadFailedException: " + String.format(a, b),
        c = Error.create(e, { name: "Sys.ScriptLoadFailedException", "scriptUrl": b });
    c.popStackFrame(); return c };
Sys._ScriptLoader._getLoadedScripts = function() { if (!Sys._ScriptLoader._referencedScripts) { Sys._ScriptLoader._referencedScripts = [];
        Sys._ScriptLoader.readLoadedScripts() } return Sys._ScriptLoader._referencedScripts };
Sys._ScriptLoaderTask = function(b, a) { this._scriptElement = b;
    this._completedCallback = a;
    this._notified = 0 };
Sys._ScriptLoaderTask.prototype = { get_scriptElement: function() { return this._scriptElement }, dispose: function() { if (this._disposed) return;
        this._disposed = true;
        this._removeScriptElementHandlers();
        Sys._ScriptLoader._clearScript(this._scriptElement);
        this._scriptElement = null }, execute: function() { this._addScriptElementHandlers();
        document.getElementsByTagName("head")[0].appendChild(this._scriptElement) }, _addScriptElementHandlers: function() { this._scriptLoadDelegate = Function.createDelegate(this, this._scriptLoadHandler); if (Sys.Browser.agent !== Sys.Browser.InternetExplorer) { this._scriptElement.readyState = "loaded";
            $addHandler(this._scriptElement, "load", this._scriptLoadDelegate) } else $addHandler(this._scriptElement, "readystatechange", this._scriptLoadDelegate); if (this._scriptElement.addEventListener) { this._scriptErrorDelegate = Function.createDelegate(this, this._scriptErrorHandler);
            this._scriptElement.addEventListener("error", this._scriptErrorDelegate, false) } }, _removeScriptElementHandlers: function() { if (this._scriptLoadDelegate) { var a = this.get_scriptElement(); if (Sys.Browser.agent !== Sys.Browser.InternetExplorer) $removeHandler(a, "load", this._scriptLoadDelegate);
            else $removeHandler(a, "readystatechange", this._scriptLoadDelegate); if (this._scriptErrorDelegate) { this._scriptElement.removeEventListener("error", this._scriptErrorDelegate, false);
                this._scriptErrorDelegate = null } this._scriptLoadDelegate = null } }, _scriptErrorHandler: function() { if (this._disposed) return;
        this._completedCallback(this.get_scriptElement(), false) }, _scriptLoadHandler: function() { if (this._disposed) return; var a = this.get_scriptElement(); if (a.readyState !== "loaded" && a.readyState !== "complete") return; var b = this;
        window.setTimeout(function() { b._completedCallback(a, true) }, 0) } };
Sys._ScriptLoaderTask.registerClass("Sys._ScriptLoaderTask", null, Sys.IDisposable);
Sys.ApplicationLoadEventArgs = function(b, a) { Sys.ApplicationLoadEventArgs.initializeBase(this);
    this._components = b;
    this._isPartialLoad = a };
Sys.ApplicationLoadEventArgs.prototype = { get_components: function() { return this._components }, get_isPartialLoad: function() { return this._isPartialLoad } };
Sys.ApplicationLoadEventArgs.registerClass("Sys.ApplicationLoadEventArgs", Sys.EventArgs);
Sys.HistoryEventArgs = function(a) { Sys.HistoryEventArgs.initializeBase(this);
    this._state = a };
Sys.HistoryEventArgs.prototype = { get_state: function() { return this._state } };
Sys.HistoryEventArgs.registerClass("Sys.HistoryEventArgs", Sys.EventArgs);
Sys._Application = function() { Sys._Application.initializeBase(this);
    this._disposableObjects = [];
    this._components = {};
    this._createdComponents = [];
    this._secondPassComponents = [];
    this._appLoadHandler = null;
    this._beginRequestHandler = null;
    this._clientId = null;
    this._currentEntry = "";
    this._endRequestHandler = null;
    this._history = null;
    this._enableHistory = false;
    this._historyFrame = null;
    this._historyInitialized = false;
    this._historyInitialLength = 0;
    this._historyLength = 0;
    this._historyPointIsNew = false;
    this._ignoreTimer = false;
    this._initialState = null;
    this._state = {};
    this._timerCookie = 0;
    this._timerHandler = null;
    this._uniqueId = null;
    this._unloadHandlerDelegate = Function.createDelegate(this, this._unloadHandler);
    this._loadHandlerDelegate = Function.createDelegate(this, this._loadHandler);
    Sys.UI.DomEvent.addHandler(window, "unload", this._unloadHandlerDelegate);
    Sys.UI.DomEvent.addHandler(window, "load", this._loadHandlerDelegate) };
Sys._Application.prototype = { _creatingComponents: false, _disposing: false, get_isCreatingComponents: function() { return this._creatingComponents }, get_stateString: function() { var a = window.location.hash; if (this._isSafari2()) { var b = this._getHistory(); if (b) a = b[window.history.length - this._historyInitialLength] } if (a.length > 0 && a.charAt(0) === "#") a = a.substring(1); if (Sys.Browser.agent === Sys.Browser.Firefox) a = this._serializeState(this._deserializeState(a, true)); return a }, get_enableHistory: function() { return this._enableHistory }, set_enableHistory: function(a) { this._enableHistory = a }, add_init: function(a) { if (this._initialized) a(this, Sys.EventArgs.Empty);
        else this.get_events().addHandler("init", a) }, remove_init: function(a) { this.get_events().removeHandler("init", a) }, add_load: function(a) { this.get_events().addHandler("load", a) }, remove_load: function(a) { this.get_events().removeHandler("load", a) }, add_navigate: function(a) { this.get_events().addHandler("navigate", a) }, remove_navigate: function(a) { this.get_events().removeHandler("navigate", a) }, add_unload: function(a) { this.get_events().addHandler("unload", a) }, remove_unload: function(a) { this.get_events().removeHandler("unload", a) }, addComponent: function(a) { this._components[a.get_id()] = a }, addHistoryPoint: function(c, f) { this._ensureHistory(); var b = this._state; for (var a in c) { var d = c[a]; if (d === null) { if (typeof b[a] !== "undefined") delete b[a] } else b[a] = d } var e = this._serializeState(b);
        this._historyPointIsNew = true;
        this._setState(e, f);
        this._raiseNavigate() }, beginCreateComponents: function() { this._creatingComponents = true }, dispose: function() { if (!this._disposing) { this._disposing = true; if (this._timerCookie) { window.clearTimeout(this._timerCookie);
                delete this._timerCookie } if (this._endRequestHandler) { Sys.WebForms.PageRequestManager.getInstance().remove_endRequest(this._endRequestHandler);
                delete this._endRequestHandler } if (this._beginRequestHandler) { Sys.WebForms.PageRequestManager.getInstance().remove_beginRequest(this._beginRequestHandler);
                delete this._beginRequestHandler } if (window.pageUnload) window.pageUnload(this, Sys.EventArgs.Empty); var c = this.get_events().getHandler("unload"); if (c) c(this, Sys.EventArgs.Empty); var b = Array.clone(this._disposableObjects); for (var a = 0, e = b.length; a < e; a++) b[a].dispose();
            Array.clear(this._disposableObjects);
            Sys.UI.DomEvent.removeHandler(window, "unload", this._unloadHandlerDelegate); if (this._loadHandlerDelegate) { Sys.UI.DomEvent.removeHandler(window, "load", this._loadHandlerDelegate);
                this._loadHandlerDelegate = null } var d = Sys._ScriptLoader.getInstance(); if (d) d.dispose();
            Sys._Application.callBaseMethod(this, "dispose") } }, endCreateComponents: function() { var b = this._secondPassComponents; for (var a = 0, d = b.length; a < d; a++) { var c = b[a].component;
            Sys$Component$_setReferences(c, b[a].references);
            c.endUpdate() } this._secondPassComponents = [];
        this._creatingComponents = false }, findComponent: function(b, a) { return a ? Sys.IContainer.isInstanceOfType(a) ? a.findComponent(b) : a[b] || null : Sys.Application._components[b] || null }, getComponents: function() { var a = [],
            b = this._components; for (var c in b) a[a.length] = b[c]; return a }, initialize: function() { if (!this._initialized && !this._initializing) { this._initializing = true;
            window.setTimeout(Function.createDelegate(this, this._doInitialize), 0) } }, notifyScriptLoaded: function() { var a = Sys._ScriptLoader.getInstance(); if (a) a.notifyScriptLoaded() }, registerDisposableObject: function(a) { if (!this._disposing) this._disposableObjects[this._disposableObjects.length] = a }, raiseLoad: function() { var b = this.get_events().getHandler("load"),
            a = new Sys.ApplicationLoadEventArgs(Array.clone(this._createdComponents), !this._initializing); if (b) b(this, a); if (window.pageLoad) window.pageLoad(this, a);
        this._createdComponents = [] }, removeComponent: function(b) { var a = b.get_id(); if (a) delete this._components[a] }, setServerId: function(a, b) { this._clientId = a;
        this._uniqueId = b }, setServerState: function(a) { this._ensureHistory();
        this._state.__s = a;
        this._updateHiddenField(a) }, unregisterDisposableObject: function(a) { if (!this._disposing) Array.remove(this._disposableObjects, a) }, _addComponentToSecondPass: function(b, a) { this._secondPassComponents[this._secondPassComponents.length] = { component: b, references: a } }, _deserializeState: function(a, i) { var e = {};
        a = a || ""; var b = a.indexOf("&&"); if (b !== -1 && b + 2 < a.length) { e.__s = a.substr(b + 2);
            a = a.substr(0, b) } var g = a.split("&"); for (var f = 0, k = g.length; f < k; f++) { var d = g[f],
                c = d.indexOf("="); if (c !== -1 && c + 1 < d.length) { var j = d.substr(0, c),
                    h = d.substr(c + 1);
                e[j] = i ? h : decodeURIComponent(h) } } return e }, _doInitialize: function() { Sys._Application.callBaseMethod(this, "initialize"); var b = this.get_events().getHandler("init"); if (b) { this.beginCreateComponents();
            b(this, Sys.EventArgs.Empty);
            this.endCreateComponents() } if (Sys.WebForms) { this._beginRequestHandler = Function.createDelegate(this, this._onPageRequestManagerBeginRequest);
            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(this._beginRequestHandler);
            this._endRequestHandler = Function.createDelegate(this, this._onPageRequestManagerEndRequest);
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(this._endRequestHandler) } var a = this.get_stateString(); if (a !== this._currentEntry) this._navigate(a);
        this.raiseLoad();
        this._initializing = false }, _enableHistoryInScriptManager: function() { this._enableHistory = true }, _ensureHistory: function() { if (!this._historyInitialized && this._enableHistory) { if (Sys.Browser.agent === Sys.Browser.InternetExplorer && Sys.Browser.documentMode < 8) { this._historyFrame = document.getElementById("__historyFrame");
                this._ignoreIFrame = true } if (this._isSafari2()) { var a = document.getElementById("__history");
                this._setHistory([window.location.hash]);
                this._historyInitialLength = window.history.length } this._timerHandler = Function.createDelegate(this, this._onIdle);
            this._timerCookie = window.setTimeout(this._timerHandler, 100); try { this._initialState = this._deserializeState(this.get_stateString()) } catch (b) {} this._historyInitialized = true } }, _getHistory: function() { var a = document.getElementById("__history"); if (!a) return ""; var b = a.value; return b ? Sys.Serialization.JavaScriptSerializer.deserialize(b, true) : "" }, _isSafari2: function() { return Sys.Browser.agent === Sys.Browser.Safari && Sys.Browser.version <= 419.3 }, _loadHandler: function() { if (this._loadHandlerDelegate) { Sys.UI.DomEvent.removeHandler(window, "load", this._loadHandlerDelegate);
            this._loadHandlerDelegate = null } this.initialize() }, _navigate: function(c) { this._ensureHistory(); var b = this._deserializeState(c); if (this._uniqueId) { var d = this._state.__s || "",
                a = b.__s || ""; if (a !== d) { this._updateHiddenField(a);
                __doPostBack(this._uniqueId, a);
                this._state = b; return } } this._setState(c);
        this._state = b;
        this._raiseNavigate() }, _onIdle: function() { delete this._timerCookie; var a = this.get_stateString(); if (a !== this._currentEntry) { if (!this._ignoreTimer) { this._historyPointIsNew = false;
                this._navigate(a);
                this._historyLength = window.history.length } } else this._ignoreTimer = false;
        this._timerCookie = window.setTimeout(this._timerHandler, 100) }, _onIFrameLoad: function(a) { this._ensureHistory(); if (!this._ignoreIFrame) { this._historyPointIsNew = false;
            this._navigate(a) } this._ignoreIFrame = false }, _onPageRequestManagerBeginRequest: function() { this._ignoreTimer = true }, _onPageRequestManagerEndRequest: function(e, d) { var b = d.get_dataItems()[this._clientId],
            a = document.getElementById("__EVENTTARGET"); if (a && a.value === this._uniqueId) a.value = ""; if (typeof b !== "undefined") { this.setServerState(b);
            this._historyPointIsNew = true } else this._ignoreTimer = false; var c = this._serializeState(this._state); if (c !== this._currentEntry) { this._ignoreTimer = true;
            this._setState(c);
            this._raiseNavigate() } }, _raiseNavigate: function() { var c = this.get_events().getHandler("navigate"),
            b = {}; for (var a in this._state)
            if (a !== "__s") b[a] = this._state[a]; var d = new Sys.HistoryEventArgs(b); if (c) c(this, d) }, _serializeState: function(d) { var b = []; for (var a in d) { var e = d[a]; if (a === "__s") var c = e;
            else b[b.length] = a + "=" + encodeURIComponent(e) } return b.join("&") + (c ? "&&" + c : "") }, _setHistory: function(b) { var a = document.getElementById("__history"); if (a) a.value = Sys.Serialization.JavaScriptSerializer.serialize(b) }, _setState: function(a, c) { a = a || ""; if (a !== this._currentEntry) { if (window.theForm) { var e = window.theForm.action,
                    f = e.indexOf("#");
                window.theForm.action = (f !== -1 ? e.substring(0, f) : e) + "#" + a } if (this._historyFrame && this._historyPointIsNew) { this._ignoreIFrame = true;
                this._historyPointIsNew = false; var d = this._historyFrame.contentWindow.document;
                d.open("javascript:'<html></html>'");
                d.write("<html><head><title>" + (c || document.title) + "</title><scri" + 'pt type="text/javascript">parent.Sys.Application._onIFrameLoad(\'' + a + "');</scri" + "pt></head><body></body></html>");
                d.close() } this._ignoreTimer = false; var h = this.get_stateString();
            this._currentEntry = a; if (a !== h) { if (this._isSafari2()) { var g = this._getHistory();
                    g[window.history.length - this._historyInitialLength + 1] = a;
                    this._setHistory(g);
                    this._historyLength = window.history.length + 1; var b = document.createElement("form");
                    b.method = "get";
                    b.action = "#" + a;
                    document.appendChild(b);
                    b.submit();
                    document.removeChild(b) } else window.location.hash = a; if (typeof c !== "undefined" && c !== null) document.title = c } } }, _unloadHandler: function() { this.dispose() }, _updateHiddenField: function(b) { if (this._clientId) { var a = document.getElementById(this._clientId); if (a) a.value = b } } };
Sys._Application.registerClass("Sys._Application", Sys.Component, Sys.IContainer);
Sys.Application = new Sys._Application;
var $find = Sys.Application.findComponent;
Type.registerNamespace("Sys.Net");
Sys.Net.WebRequestExecutor = function() { this._webRequest = null;
    this._resultObject = null };
Sys.Net.WebRequestExecutor.prototype = { get_webRequest: function() { return this._webRequest }, _set_webRequest: function(a) { this._webRequest = a }, get_started: function() { throw Error.notImplemented() }, get_responseAvailable: function() { throw Error.notImplemented() }, get_timedOut: function() { throw Error.notImplemented() }, get_aborted: function() { throw Error.notImplemented() }, get_responseData: function() { throw Error.notImplemented() }, get_statusCode: function() { throw Error.notImplemented() }, get_statusText: function() { throw Error.notImplemented() }, get_xml: function() { throw Error.notImplemented() }, get_object: function() { if (!this._resultObject) this._resultObject = Sys.Serialization.JavaScriptSerializer.deserialize(this.get_responseData()); return this._resultObject }, executeRequest: function() { throw Error.notImplemented() }, abort: function() { throw Error.notImplemented() }, getResponseHeader: function() { throw Error.notImplemented() }, getAllResponseHeaders: function() { throw Error.notImplemented() } };
Sys.Net.WebRequestExecutor.registerClass("Sys.Net.WebRequestExecutor");
Sys.Net.XMLDOM = function(d) { if (!window.DOMParser) { var c = ["Msxml2.DOMDocument.3.0", "Msxml2.DOMDocument"]; for (var b = 0, f = c.length; b < f; b++) try { var a = new ActiveXObject(c[b]);
            a.async = false;
            a.loadXML(d);
            a.setProperty("SelectionLanguage", "XPath"); return a } catch (g) {} } else try { var e = new window.DOMParser; return e.parseFromString(d, "text/xml") } catch (g) {}
    return null };
Sys.Net.XMLHttpExecutor = function() { Sys.Net.XMLHttpExecutor.initializeBase(this); var a = this;
    this._xmlHttpRequest = null;
    this._webRequest = null;
    this._responseAvailable = false;
    this._timedOut = false;
    this._timer = null;
    this._aborted = false;
    this._started = false;
    this._onReadyStateChange = function() { if (a._xmlHttpRequest.readyState === 4) { try { if (typeof a._xmlHttpRequest.status === "undefined") return } catch (b) { return } a._clearTimer();
            a._responseAvailable = true; try { a._webRequest.completed(Sys.EventArgs.Empty) } finally { if (a._xmlHttpRequest != null) { a._xmlHttpRequest.onreadystatechange = Function.emptyMethod;
                    a._xmlHttpRequest = null } } } };
    this._clearTimer = function() { if (a._timer != null) { window.clearTimeout(a._timer);
            a._timer = null } };
    this._onTimeout = function() { if (!a._responseAvailable) { a._clearTimer();
            a._timedOut = true;
            a._xmlHttpRequest.onreadystatechange = Function.emptyMethod;
            a._xmlHttpRequest.abort();
            a._webRequest.completed(Sys.EventArgs.Empty);
            a._xmlHttpRequest = null } } };
Sys.Net.XMLHttpExecutor.prototype = { get_timedOut: function() { return this._timedOut }, get_started: function() { return this._started }, get_responseAvailable: function() { return this._responseAvailable }, get_aborted: function() { return this._aborted }, executeRequest: function() { this._webRequest = this.get_webRequest(); var c = this._webRequest.get_body(),
            a = this._webRequest.get_headers();
        this._xmlHttpRequest = new XMLHttpRequest;
        this._xmlHttpRequest.onreadystatechange = this._onReadyStateChange; var e = this._webRequest.get_httpVerb();
        this._xmlHttpRequest.open(e, this._webRequest.getResolvedUrl(), true); if (a)
            for (var b in a) { var f = a[b]; if (typeof f !== "function") this._xmlHttpRequest.setRequestHeader(b, f) }
        if (e.toLowerCase() === "post") { if (a === null || !a["Content-Type"]) this._xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8"); if (!c) c = "" } var d = this._webRequest.get_timeout(); if (d > 0) this._timer = window.setTimeout(Function.createDelegate(this, this._onTimeout), d);
        this._xmlHttpRequest.send(c);
        this._started = true }, getResponseHeader: function(b) { var a; try { a = this._xmlHttpRequest.getResponseHeader(b) } catch (c) {} if (!a) a = ""; return a }, getAllResponseHeaders: function() { return this._xmlHttpRequest.getAllResponseHeaders() }, get_responseData: function() { return this._xmlHttpRequest.responseText }, get_statusCode: function() { var a = 0; try { a = this._xmlHttpRequest.status } catch (b) {} return a }, get_statusText: function() { return this._xmlHttpRequest.statusText }, get_xml: function() { var a = this._xmlHttpRequest.responseXML; if (!a || !a.documentElement) { a = Sys.Net.XMLDOM(this._xmlHttpRequest.responseText); if (!a || !a.documentElement) return null } else if (navigator.userAgent.indexOf("MSIE") !== -1) a.setProperty("SelectionLanguage", "XPath"); if (a.documentElement.namespaceURI === "http://www.mozilla.org/newlayout/xml/parsererror.xml" && a.documentElement.tagName === "parsererror") return null; if (a.documentElement.firstChild && a.documentElement.firstChild.tagName === "parsererror") return null; return a }, abort: function() { if (this._aborted || this._responseAvailable || this._timedOut) return;
        this._aborted = true;
        this._clearTimer(); if (this._xmlHttpRequest && !this._responseAvailable) { this._xmlHttpRequest.onreadystatechange = Function.emptyMethod;
            this._xmlHttpRequest.abort();
            this._xmlHttpRequest = null;
            this._webRequest.completed(Sys.EventArgs.Empty) } } };
Sys.Net.XMLHttpExecutor.registerClass("Sys.Net.XMLHttpExecutor", Sys.Net.WebRequestExecutor);
Sys.Net._WebRequestManager = function() { this._defaultTimeout = 0;
    this._defaultExecutorType = "Sys.Net.XMLHttpExecutor" };
Sys.Net._WebRequestManager.prototype = { add_invokingRequest: function(a) { this._get_eventHandlerList().addHandler("invokingRequest", a) }, remove_invokingRequest: function(a) { this._get_eventHandlerList().removeHandler("invokingRequest", a) }, add_completedRequest: function(a) { this._get_eventHandlerList().addHandler("completedRequest", a) }, remove_completedRequest: function(a) { this._get_eventHandlerList().removeHandler("completedRequest", a) }, _get_eventHandlerList: function() { if (!this._events) this._events = new Sys.EventHandlerList; return this._events }, get_defaultTimeout: function() { return this._defaultTimeout }, set_defaultTimeout: function(a) { this._defaultTimeout = a }, get_defaultExecutorType: function() { return this._defaultExecutorType }, set_defaultExecutorType: function(a) { this._defaultExecutorType = a }, executeRequest: function(webRequest) { var executor = webRequest.get_executor(); if (!executor) { var failed = false; try { var executorType = eval(this._defaultExecutorType);
                executor = new executorType } catch (a) { failed = true } webRequest.set_executor(executor) } if (executor.get_aborted()) return; var evArgs = new Sys.Net.NetworkRequestEventArgs(webRequest),
            handler = this._get_eventHandlerList().getHandler("invokingRequest"); if (handler) handler(this, evArgs); if (!evArgs.get_cancel()) executor.executeRequest() } };
Sys.Net._WebRequestManager.registerClass("Sys.Net._WebRequestManager");
Sys.Net.WebRequestManager = new Sys.Net._WebRequestManager;
Sys.Net.NetworkRequestEventArgs = function(a) { Sys.Net.NetworkRequestEventArgs.initializeBase(this);
    this._webRequest = a };
Sys.Net.NetworkRequestEventArgs.prototype = { get_webRequest: function() { return this._webRequest } };
Sys.Net.NetworkRequestEventArgs.registerClass("Sys.Net.NetworkRequestEventArgs", Sys.CancelEventArgs);
Sys.Net.WebRequest = function() { this._url = "";
    this._headers = {};
    this._body = null;
    this._userContext = null;
    this._httpVerb = null;
    this._executor = null;
    this._invokeCalled = false;
    this._timeout = 0 };
Sys.Net.WebRequest.prototype = { add_completed: function(a) { this._get_eventHandlerList().addHandler("completed", a) }, remove_completed: function(a) { this._get_eventHandlerList().removeHandler("completed", a) }, completed: function(b) { var a = Sys.Net.WebRequestManager._get_eventHandlerList().getHandler("completedRequest"); if (a) a(this._executor, b);
        a = this._get_eventHandlerList().getHandler("completed"); if (a) a(this._executor, b) }, _get_eventHandlerList: function() { if (!this._events) this._events = new Sys.EventHandlerList; return this._events }, get_url: function() { return this._url }, set_url: function(a) { this._url = a }, get_headers: function() { return this._headers }, get_httpVerb: function() { if (this._httpVerb === null) { if (this._body === null) return "GET"; return "POST" } return this._httpVerb }, set_httpVerb: function(a) { this._httpVerb = a }, get_body: function() { return this._body }, set_body: function(a) { this._body = a }, get_userContext: function() { return this._userContext }, set_userContext: function(a) { this._userContext = a }, get_executor: function() { return this._executor }, set_executor: function(a) { this._executor = a;
        this._executor._set_webRequest(this) }, get_timeout: function() { if (this._timeout === 0) return Sys.Net.WebRequestManager.get_defaultTimeout(); return this._timeout }, set_timeout: function(a) { this._timeout = a }, getResolvedUrl: function() { return Sys.Net.WebRequest._resolveUrl(this._url) }, invoke: function() { Sys.Net.WebRequestManager.executeRequest(this);
        this._invokeCalled = true } };
Sys.Net.WebRequest._resolveUrl = function(b, a) { if (b && b.indexOf("://") !== -1) return b; if (!a || a.length === 0) { var d = document.getElementsByTagName("base")[0]; if (d && d.href && d.href.length > 0) a = d.href;
        else a = document.URL } var c = a.indexOf("?"); if (c !== -1) a = a.substr(0, c);
    c = a.indexOf("#"); if (c !== -1) a = a.substr(0, c);
    a = a.substr(0, a.lastIndexOf("/") + 1); if (!b || b.length === 0) return a; if (b.charAt(0) === "/") { var e = a.indexOf("://"),
            g = a.indexOf("/", e + 3); return a.substr(0, g) + b } else { var f = a.lastIndexOf("/"); return a.substr(0, f + 1) + b } };
Sys.Net.WebRequest._createQueryString = function(d, b) { if (!b) b = encodeURIComponent; var a = new Sys.StringBuilder,
        f = 0; for (var c in d) { var e = d[c]; if (typeof e === "function") continue; var g = Sys.Serialization.JavaScriptSerializer.serialize(e); if (f !== 0) a.append("&");
        a.append(c);
        a.append("=");
        a.append(b(g));
        f++ } return a.toString() };
Sys.Net.WebRequest._createUrl = function(a, b) { if (!b) return a; var d = Sys.Net.WebRequest._createQueryString(b); if (d.length > 0) { var c = "?"; if (a && a.indexOf("?") !== -1) c = "&"; return a + c + d } else return a };
Sys.Net.WebRequest.registerClass("Sys.Net.WebRequest");
Sys.Net.WebServiceProxy = function() {};
Sys.Net.WebServiceProxy.prototype = { get_timeout: function() { return this._timeout }, set_timeout: function(a) { if (a < 0) throw Error.argumentOutOfRange("value", a, Sys.Res.invalidTimeout);
        this._timeout = a }, get_defaultUserContext: function() { return this._userContext }, set_defaultUserContext: function(a) { this._userContext = a }, get_defaultSucceededCallback: function() { return this._succeeded }, set_defaultSucceededCallback: function(a) { this._succeeded = a }, get_defaultFailedCallback: function() { return this._failed }, set_defaultFailedCallback: function(a) { this._failed = a }, get_path: function() { return this._path }, set_path: function(a) { this._path = a }, _invoke: function(d, e, g, f, c, b, a) { if (c === null || typeof c === "undefined") c = this.get_defaultSucceededCallback(); if (b === null || typeof b === "undefined") b = this.get_defaultFailedCallback(); if (a === null || typeof a === "undefined") a = this.get_defaultUserContext(); return Sys.Net.WebServiceProxy.invoke(d, e, g, f, c, b, a, this.get_timeout()) } };
Sys.Net.WebServiceProxy.registerClass("Sys.Net.WebServiceProxy");
Sys.Net.WebServiceProxy.invoke = function(k, a, j, d, i, c, f, h) { var b = new Sys.Net.WebRequest;
    b.get_headers()["Content-Type"] = "application/json; charset=utf-8"; if (!d) d = {}; var g = d; if (!j || !g) g = {};
    b.set_url(Sys.Net.WebRequest._createUrl(k + "/" + encodeURIComponent(a), g)); var e = null; if (!j) { e = Sys.Serialization.JavaScriptSerializer.serialize(d); if (e === "{}") e = "" } b.set_body(e);
    b.add_completed(l); if (h && h > 0) b.set_timeout(h);
    b.invoke();

    function l(d) { if (d.get_responseAvailable()) { var g = d.get_statusCode(),
                b = null; try { var e = d.getResponseHeader("Content-Type"); if (e.startsWith("application/json")) b = d.get_object();
                else if (e.startsWith("text/xml")) b = d.get_xml();
                else b = d.get_responseData() } catch (m) {} var k = d.getResponseHeader("jsonerror"),
                h = k === "true"; if (h) { if (b) b = new Sys.Net.WebServiceError(false, b.Message, b.StackTrace, b.ExceptionType) } else if (e.startsWith("application/json")) b = b.d; if (g < 200 || g >= 300 || h) { if (c) { if (!b || !h) b = new Sys.Net.WebServiceError(false, String.format(Sys.Res.webServiceFailedNoMsg, a), "", "");
                    b._statusCode = g;
                    c(b, f, a) } } else if (i) i(b, f, a) } else { var j; if (d.get_timedOut()) j = String.format(Sys.Res.webServiceTimedOut, a);
            else j = String.format(Sys.Res.webServiceFailedNoMsg, a); if (c) c(new Sys.Net.WebServiceError(d.get_timedOut(), j, "", ""), f, a) } } return b };
Sys.Net.WebServiceProxy._generateTypedConstructor = function(a) { return function(b) { if (b)
            for (var c in b) this[c] = b[c];
        this.__type = a } };
Sys.Net.WebServiceError = function(c, d, b, a) { this._timedOut = c;
    this._message = d;
    this._stackTrace = b;
    this._exceptionType = a;
    this._statusCode = -1 };
Sys.Net.WebServiceError.prototype = { get_timedOut: function() { return this._timedOut }, get_statusCode: function() { return this._statusCode }, get_message: function() { return this._message }, get_stackTrace: function() { return this._stackTrace }, get_exceptionType: function() { return this._exceptionType } };
Sys.Net.WebServiceError.registerClass("Sys.Net.WebServiceError");
Type.registerNamespace("Sys.Services");
Sys.Services._ProfileService = function() { Sys.Services._ProfileService.initializeBase(this);
    this.properties = {} };
Sys.Services._ProfileService.DefaultWebServicePath = "";
Sys.Services._ProfileService.prototype = { _defaultLoadCompletedCallback: null, _defaultSaveCompletedCallback: null, _path: "", _timeout: 0, get_defaultLoadCompletedCallback: function() { return this._defaultLoadCompletedCallback }, set_defaultLoadCompletedCallback: function(a) { this._defaultLoadCompletedCallback = a }, get_defaultSaveCompletedCallback: function() { return this._defaultSaveCompletedCallback }, set_defaultSaveCompletedCallback: function(a) { this._defaultSaveCompletedCallback = a }, get_path: function() { return this._path || "" }, load: function(c, d, e, f) { var b, a; if (!c) { a = "GetAllPropertiesForCurrentUser";
            b = { authenticatedUserOnly: false } } else { a = "GetPropertiesForCurrentUser";
            b = { properties: this._clonePropertyNames(c), authenticatedUserOnly: false } } this._invoke(this._get_path(), a, false, b, Function.createDelegate(this, this._onLoadComplete), Function.createDelegate(this, this._onLoadFailed), [d, e, f]) }, save: function(d, b, c, e) { var a = this._flattenProperties(d, this.properties);
        this._invoke(this._get_path(), "SetPropertiesForCurrentUser", false, { values: a.value, authenticatedUserOnly: false }, Function.createDelegate(this, this._onSaveComplete), Function.createDelegate(this, this._onSaveFailed), [b, c, e, a.count]) }, _clonePropertyNames: function(e) { var c = [],
            d = {}; for (var b = 0; b < e.length; b++) { var a = e[b]; if (!d[a]) { Array.add(c, a);
                d[a] = true } } return c }, _flattenProperties: function(a, i, j) { var b = {},
            e, d, g = 0; if (a && a.length === 0) return { value: b, count: 0 }; for (var c in i) { e = i[c];
            d = j ? j + "." + c : c; if (Sys.Services.ProfileGroup.isInstanceOfType(e)) { var k = this._flattenProperties(a, e, d),
                    h = k.value;
                g += k.count; for (var f in h) { var l = h[f];
                    b[f] = l } } else if (!a || Array.indexOf(a, d) !== -1) { b[d] = e;
                g++ } } return { value: b, count: g } }, _get_path: function() { var a = this.get_path(); if (!a.length) a = Sys.Services._ProfileService.DefaultWebServicePath; if (!a || !a.length) throw Error.invalidOperation(Sys.Res.servicePathNotSet); return a }, _onLoadComplete: function(a, e, g) { if (typeof a !== "object") throw Error.invalidOperation(String.format(Sys.Res.webServiceInvalidReturnType, g, "Object")); var c = this._unflattenProperties(a); for (var b in c) this.properties[b] = c[b]; var d = e[0] || this.get_defaultLoadCompletedCallback() || this.get_defaultSucceededCallback(); if (d) { var f = e[2] || this.get_defaultUserContext();
            d(a.length, f, "Sys.Services.ProfileService.load") } }, _onLoadFailed: function(d, b) { var a = b[1] || this.get_defaultFailedCallback(); if (a) { var c = b[2] || this.get_defaultUserContext();
            a(d, c, "Sys.Services.ProfileService.load") } }, _onSaveComplete: function(a, b, f) { var c = b[3]; if (a !== null)
            if (a instanceof Array) c -= a.length;
            else if (typeof a === "number") c = a;
        else throw Error.invalidOperation(String.format(Sys.Res.webServiceInvalidReturnType, f, "Array")); var d = b[0] || this.get_defaultSaveCompletedCallback() || this.get_defaultSucceededCallback(); if (d) { var e = b[2] || this.get_defaultUserContext();
            d(c, e, "Sys.Services.ProfileService.save") } }, _onSaveFailed: function(d, b) { var a = b[1] || this.get_defaultFailedCallback(); if (a) { var c = b[2] || this.get_defaultUserContext();
            a(d, c, "Sys.Services.ProfileService.save") } }, _unflattenProperties: function(e) { var c = {},
            d, f, h = 0; for (var a in e) { h++;
            f = e[a];
            d = a.indexOf("."); if (d !== -1) { var g = a.substr(0, d);
                a = a.substr(d + 1); var b = c[g]; if (!b || !Sys.Services.ProfileGroup.isInstanceOfType(b)) { b = new Sys.Services.ProfileGroup;
                    c[g] = b } b[a] = f } else c[a] = f } e.length = h; return c } };
Sys.Services._ProfileService.registerClass("Sys.Services._ProfileService", Sys.Net.WebServiceProxy);
Sys.Services.ProfileService = new Sys.Services._ProfileService;
Sys.Services.ProfileGroup = function(a) { if (a)
        for (var b in a) this[b] = a[b] };
Sys.Services.ProfileGroup.registerClass("Sys.Services.ProfileGroup");
Sys.Services._AuthenticationService = function() { Sys.Services._AuthenticationService.initializeBase(this) };
Sys.Services._AuthenticationService.DefaultWebServicePath = "";
Sys.Services._AuthenticationService.prototype = { _defaultLoginCompletedCallback: null, _defaultLogoutCompletedCallback: null, _path: "", _timeout: 0, _authenticated: false, get_defaultLoginCompletedCallback: function() { return this._defaultLoginCompletedCallback }, set_defaultLoginCompletedCallback: function(a) { this._defaultLoginCompletedCallback = a }, get_defaultLogoutCompletedCallback: function() { return this._defaultLogoutCompletedCallback }, set_defaultLogoutCompletedCallback: function(a) { this._defaultLogoutCompletedCallback = a }, get_isLoggedIn: function() { return this._authenticated }, get_path: function() { return this._path || "" }, login: function(c, b, a, h, f, d, e, g) { this._invoke(this._get_path(), "Login", false, { userName: c, password: b, createPersistentCookie: a }, Function.createDelegate(this, this._onLoginComplete), Function.createDelegate(this, this._onLoginFailed), [c, b, a, h, f, d, e, g]) }, logout: function(c, a, b, d) { this._invoke(this._get_path(), "Logout", false, {}, Function.createDelegate(this, this._onLogoutComplete), Function.createDelegate(this, this._onLogoutFailed), [c, a, b, d]) }, _get_path: function() { var a = this.get_path(); if (!a.length) a = Sys.Services._AuthenticationService.DefaultWebServicePath; if (!a || !a.length) throw Error.invalidOperation(Sys.Res.servicePathNotSet); return a }, _onLoginComplete: function(e, c, f) { if (typeof e !== "boolean") throw Error.invalidOperation(String.format(Sys.Res.webServiceInvalidReturnType, f, "Boolean")); var b = c[4],
            d = c[7] || this.get_defaultUserContext(),
            a = c[5] || this.get_defaultLoginCompletedCallback() || this.get_defaultSucceededCallback(); if (e) { this._authenticated = true; if (a) a(true, d, "Sys.Services.AuthenticationService.login"); if (typeof b !== "undefined" && b !== null) window.location.href = b } else if (a) a(false, d, "Sys.Services.AuthenticationService.login") }, _onLoginFailed: function(d, b) { var a = b[6] || this.get_defaultFailedCallback(); if (a) { var c = b[7] || this.get_defaultUserContext();
            a(d, c, "Sys.Services.AuthenticationService.login") } }, _onLogoutComplete: function(f, a, e) { if (f !== null) throw Error.invalidOperation(String.format(Sys.Res.webServiceInvalidReturnType, e, "null")); var b = a[0],
            d = a[3] || this.get_defaultUserContext(),
            c = a[1] || this.get_defaultLogoutCompletedCallback() || this.get_defaultSucceededCallback();
        this._authenticated = false; if (c) c(null, d, "Sys.Services.AuthenticationService.logout"); if (!b) window.location.reload();
        else window.location.href = b }, _onLogoutFailed: function(c, b) { var a = b[2] || this.get_defaultFailedCallback(); if (a) a(c, b[3], "Sys.Services.AuthenticationService.logout") }, _setAuthenticated: function(a) { this._authenticated = a } };
Sys.Services._AuthenticationService.registerClass("Sys.Services._AuthenticationService", Sys.Net.WebServiceProxy);
Sys.Services.AuthenticationService = new Sys.Services._AuthenticationService;
Sys.Services._RoleService = function() { Sys.Services._RoleService.initializeBase(this);
    this._roles = [] };
Sys.Services._RoleService.DefaultWebServicePath = "";
Sys.Services._RoleService.prototype = { _defaultLoadCompletedCallback: null, _rolesIndex: null, _timeout: 0, _path: "", get_defaultLoadCompletedCallback: function() { return this._defaultLoadCompletedCallback }, set_defaultLoadCompletedCallback: function(a) { this._defaultLoadCompletedCallback = a }, get_path: function() { return this._path || "" }, get_roles: function() { return Array.clone(this._roles) }, isUserInRole: function(a) { var b = this._get_rolesIndex()[a.trim().toLowerCase()]; return !!b }, load: function(a, b, c) { Sys.Net.WebServiceProxy.invoke(this._get_path(), "GetRolesForCurrentUser", false, {}, Function.createDelegate(this, this._onLoadComplete), Function.createDelegate(this, this._onLoadFailed), [a, b, c], this.get_timeout()) }, _get_path: function() { var a = this.get_path(); if (!a || !a.length) a = Sys.Services._RoleService.DefaultWebServicePath; if (!a || !a.length) throw Error.invalidOperation(Sys.Res.servicePathNotSet); return a }, _get_rolesIndex: function() { if (!this._rolesIndex) { var b = {}; for (var a = 0; a < this._roles.length; a++) b[this._roles[a].toLowerCase()] = true;
            this._rolesIndex = b } return this._rolesIndex }, _onLoadComplete: function(a, c, f) { if (a && !(a instanceof Array)) throw Error.invalidOperation(String.format(Sys.Res.webServiceInvalidReturnType, f, "Array"));
        this._roles = a;
        this._rolesIndex = null; var b = c[0] || this.get_defaultLoadCompletedCallback() || this.get_defaultSucceededCallback(); if (b) { var e = c[2] || this.get_defaultUserContext(),
                d = Array.clone(a);
            b(d, e, "Sys.Services.RoleService.load") } }, _onLoadFailed: function(d, b) { var a = b[1] || this.get_defaultFailedCallback(); if (a) { var c = b[2] || this.get_defaultUserContext();
            a(d, c, "Sys.Services.RoleService.load") } } };
Sys.Services._RoleService.registerClass("Sys.Services._RoleService", Sys.Net.WebServiceProxy);
Sys.Services.RoleService = new Sys.Services._RoleService;
Type.registerNamespace("Sys.Serialization");
Sys.Serialization.JavaScriptSerializer = function() {};
Sys.Serialization.JavaScriptSerializer.registerClass("Sys.Serialization.JavaScriptSerializer");
Sys.Serialization.JavaScriptSerializer._charsToEscapeRegExs = [];
Sys.Serialization.JavaScriptSerializer._charsToEscape = [];
Sys.Serialization.JavaScriptSerializer._dateRegEx = new RegExp('(^|[^\\\\])\\"\\\\/Date\\((-?[0-9]+)(?:[a-zA-Z]|(?:\\+|-)[0-9]{4})?\\)\\\\/\\"', "g");
Sys.Serialization.JavaScriptSerializer._escapeChars = {};
Sys.Serialization.JavaScriptSerializer._escapeRegEx = new RegExp('["\\\\\\x00-\\x1F]', "i");
Sys.Serialization.JavaScriptSerializer._escapeRegExGlobal = new RegExp('["\\\\\\x00-\\x1F]', "g");
Sys.Serialization.JavaScriptSerializer._jsonRegEx = new RegExp("[^,:{}\\[\\]0-9.\\-+Eaeflnr-u \\n\\r\\t]", "g");
Sys.Serialization.JavaScriptSerializer._jsonStringRegEx = new RegExp('"(\\\\.|[^"\\\\])*"', "g");
Sys.Serialization.JavaScriptSerializer._serverTypeFieldName = "__type";
Sys.Serialization.JavaScriptSerializer._init = function() { var c = ["\\u0000", "\\u0001", "\\u0002", "\\u0003", "\\u0004", "\\u0005", "\\u0006", "\\u0007", "\\b", "\\t", "\\n", "\\u000b", "\\f", "\\r", "\\u000e", "\\u000f", "\\u0010", "\\u0011", "\\u0012", "\\u0013", "\\u0014", "\\u0015", "\\u0016", "\\u0017", "\\u0018", "\\u0019", "\\u001a", "\\u001b", "\\u001c", "\\u001d", "\\u001e", "\\u001f"];
    Sys.Serialization.JavaScriptSerializer._charsToEscape[0] = "\\";
    Sys.Serialization.JavaScriptSerializer._charsToEscapeRegExs["\\"] = new RegExp("\\\\", "g");
    Sys.Serialization.JavaScriptSerializer._escapeChars["\\"] = "\\\\";
    Sys.Serialization.JavaScriptSerializer._charsToEscape[1] = '"';
    Sys.Serialization.JavaScriptSerializer._charsToEscapeRegExs['"'] = new RegExp('"', "g");
    Sys.Serialization.JavaScriptSerializer._escapeChars['"'] = '\\"'; for (var a = 0; a < 32; a++) { var b = String.fromCharCode(a);
        Sys.Serialization.JavaScriptSerializer._charsToEscape[a + 2] = b;
        Sys.Serialization.JavaScriptSerializer._charsToEscapeRegExs[b] = new RegExp(b, "g");
        Sys.Serialization.JavaScriptSerializer._escapeChars[b] = c[a] } };
Sys.Serialization.JavaScriptSerializer._serializeBooleanWithBuilder = function(b, a) { a.append(b.toString()) };
Sys.Serialization.JavaScriptSerializer._serializeNumberWithBuilder = function(a, b) { if (isFinite(a)) b.append(String(a));
    else throw Error.invalidOperation(Sys.Res.cannotSerializeNonFiniteNumbers) };
Sys.Serialization.JavaScriptSerializer._serializeStringWithBuilder = function(a, c) { c.append('"'); if (Sys.Serialization.JavaScriptSerializer._escapeRegEx.test(a)) { if (Sys.Serialization.JavaScriptSerializer._charsToEscape.length === 0) Sys.Serialization.JavaScriptSerializer._init(); if (a.length < 128) a = a.replace(Sys.Serialization.JavaScriptSerializer._escapeRegExGlobal, function(a) { return Sys.Serialization.JavaScriptSerializer._escapeChars[a] });
        else
            for (var d = 0; d < 34; d++) { var b = Sys.Serialization.JavaScriptSerializer._charsToEscape[d]; if (a.indexOf(b) !== -1)
                    if (Sys.Browser.agent === Sys.Browser.Opera || Sys.Browser.agent === Sys.Browser.FireFox) a = a.split(b).join(Sys.Serialization.JavaScriptSerializer._escapeChars[b]);
                    else a = a.replace(Sys.Serialization.JavaScriptSerializer._charsToEscapeRegExs[b], Sys.Serialization.JavaScriptSerializer._escapeChars[b]) } } c.append(a);
    c.append('"') };
Sys.Serialization.JavaScriptSerializer._serializeWithBuilder = function(b, a, i, g) { var c; switch (typeof b) {
        case "object":
            if (b)
                if (Number.isInstanceOfType(b)) Sys.Serialization.JavaScriptSerializer._serializeNumberWithBuilder(b, a);
                else if (Boolean.isInstanceOfType(b)) Sys.Serialization.JavaScriptSerializer._serializeBooleanWithBuilder(b, a);
            else if (String.isInstanceOfType(b)) Sys.Serialization.JavaScriptSerializer._serializeStringWithBuilder(b, a);
            else if (Array.isInstanceOfType(b)) { a.append("["); for (c = 0; c < b.length; ++c) { if (c > 0) a.append(",");
                    Sys.Serialization.JavaScriptSerializer._serializeWithBuilder(b[c], a, false, g) } a.append("]") } else { if (Date.isInstanceOfType(b)) { a.append('"\\/Date(');
                    a.append(b.getTime());
                    a.append(')\\/"'); break } var d = [],
                    f = 0; for (var e in b) { if (e.startsWith("$")) continue; if (e === Sys.Serialization.JavaScriptSerializer._serverTypeFieldName && f !== 0) { d[f++] = d[0];
                        d[0] = e } else d[f++] = e } if (i) d.sort();
                a.append("{"); var j = false; for (c = 0; c < f; c++) { var h = b[d[c]]; if (typeof h !== "undefined" && typeof h !== "function") { if (j) a.append(",");
                        else j = true;
                        Sys.Serialization.JavaScriptSerializer._serializeWithBuilder(d[c], a, i, g);
                        a.append(":");
                        Sys.Serialization.JavaScriptSerializer._serializeWithBuilder(h, a, i, g) } } a.append("}") } else a.append("null"); break;
        case "number":
            Sys.Serialization.JavaScriptSerializer._serializeNumberWithBuilder(b, a); break;
        case "string":
            Sys.Serialization.JavaScriptSerializer._serializeStringWithBuilder(b, a); break;
        case "boolean":
            Sys.Serialization.JavaScriptSerializer._serializeBooleanWithBuilder(b, a); break;
        default:
            a.append("null") } };
Sys.Serialization.JavaScriptSerializer.serialize = function(b) { var a = new Sys.StringBuilder;
    Sys.Serialization.JavaScriptSerializer._serializeWithBuilder(b, a, false); return a.toString() };
Sys.Serialization.JavaScriptSerializer.deserialize = function(data, secure) { if (data.length === 0) throw Error.argument("data", Sys.Res.cannotDeserializeEmptyString); try { var exp = data.replace(Sys.Serialization.JavaScriptSerializer._dateRegEx, "$1new Date($2)"); if (secure && Sys.Serialization.JavaScriptSerializer._jsonRegEx.test(exp.replace(Sys.Serialization.JavaScriptSerializer._jsonStringRegEx, ""))) throw null; return eval("(" + exp + ")") } catch (a) { throw Error.argument("data", Sys.Res.cannotDeserializeInvalidJson) } };
Sys.CultureInfo = function(c, b, a) { this.name = c;
    this.numberFormat = b;
    this.dateTimeFormat = a };
Sys.CultureInfo.prototype = { _getDateTimeFormats: function() { if (!this._dateTimeFormats) { var a = this.dateTimeFormat;
            this._dateTimeFormats = [a.MonthDayPattern, a.YearMonthPattern, a.ShortDatePattern, a.ShortTimePattern, a.LongDatePattern, a.LongTimePattern, a.FullDateTimePattern, a.RFC1123Pattern, a.SortableDateTimePattern, a.UniversalSortableDateTimePattern] } return this._dateTimeFormats }, _getMonthIndex: function(a) { if (!this._upperMonths) this._upperMonths = this._toUpperArray(this.dateTimeFormat.MonthNames); return Array.indexOf(this._upperMonths, this._toUpper(a)) }, _getAbbrMonthIndex: function(a) { if (!this._upperAbbrMonths) this._upperAbbrMonths = this._toUpperArray(this.dateTimeFormat.AbbreviatedMonthNames); return Array.indexOf(this._upperAbbrMonths, this._toUpper(a)) }, _getDayIndex: function(a) { if (!this._upperDays) this._upperDays = this._toUpperArray(this.dateTimeFormat.DayNames); return Array.indexOf(this._upperDays, this._toUpper(a)) }, _getAbbrDayIndex: function(a) { if (!this._upperAbbrDays) this._upperAbbrDays = this._toUpperArray(this.dateTimeFormat.AbbreviatedDayNames); return Array.indexOf(this._upperAbbrDays, this._toUpper(a)) }, _toUpperArray: function(c) { var b = []; for (var a = 0, d = c.length; a < d; a++) b[a] = this._toUpper(c[a]); return b }, _toUpper: function(a) { return a.split("\u00a0").join(" ").toUpperCase() } };
Sys.CultureInfo._parse = function(b) { var a = Sys.Serialization.JavaScriptSerializer.deserialize(b); return new Sys.CultureInfo(a.name, a.numberFormat, a.dateTimeFormat) };
Sys.CultureInfo.registerClass("Sys.CultureInfo");
Sys.CultureInfo.InvariantCulture = Sys.CultureInfo._parse('{"name":"","numberFormat":{"CurrencyDecimalDigits":2,"CurrencyDecimalSeparator":".","IsReadOnly":true,"CurrencyGroupSizes":[3],"NumberGroupSizes":[3],"PercentGroupSizes":[3],"CurrencyGroupSeparator":",","CurrencySymbol":"\u00a4","NaNSymbol":"NaN","CurrencyNegativePattern":0,"NumberNegativePattern":1,"PercentPositivePattern":0,"PercentNegativePattern":0,"NegativeInfinitySymbol":"-Infinity","NegativeSign":"-","NumberDecimalDigits":2,"NumberDecimalSeparator":".","NumberGroupSeparator":",","CurrencyPositivePattern":0,"PositiveInfinitySymbol":"Infinity","PositiveSign":"+","PercentDecimalDigits":2,"PercentDecimalSeparator":".","PercentGroupSeparator":",","PercentSymbol":"%","PerMilleSymbol":"\u2030","NativeDigits":["0","1","2","3","4","5","6","7","8","9"],"DigitSubstitution":1},"dateTimeFormat":{"AMDesignator":"AM","Calendar":{"MinSupportedDateTime":"@-62135568000000@","MaxSupportedDateTime":"@253402300799999@","AlgorithmType":1,"CalendarType":1,"Eras":[1],"TwoDigitYearMax":2029,"IsReadOnly":true},"DateSeparator":"/","FirstDayOfWeek":0,"CalendarWeekRule":0,"FullDateTimePattern":"dddd, dd MMMM yyyy HH:mm:ss","LongDatePattern":"dddd, dd MMMM yyyy","LongTimePattern":"HH:mm:ss","MonthDayPattern":"MMMM dd","PMDesignator":"PM","RFC1123Pattern":"ddd, dd MMM yyyy HH\':\'mm\':\'ss \'GMT\'","ShortDatePattern":"MM/dd/yyyy","ShortTimePattern":"HH:mm","SortableDateTimePattern":"yyyy\'-\'MM\'-\'dd\'T\'HH\':\'mm\':\'ss","TimeSeparator":":","UniversalSortableDateTimePattern":"yyyy\'-\'MM\'-\'dd HH\':\'mm\':\'ss\'Z\'","YearMonthPattern":"yyyy MMMM","AbbreviatedDayNames":["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],"ShortestDayNames":["Su","Mo","Tu","We","Th","Fr","Sa"],"DayNames":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],"AbbreviatedMonthNames":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec",""],"MonthNames":["January","February","March","April","May","June","July","August","September","October","November","December",""],"IsReadOnly":true,"NativeCalendarName":"Gregorian Calendar","AbbreviatedMonthGenitiveNames":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec",""],"MonthGenitiveNames":["January","February","March","April","May","June","July","August","September","October","November","December",""]}}');
if (typeof __cultureInfo === "undefined") var __cultureInfo = '{"name":"en-US","numberFormat":{"CurrencyDecimalDigits":2,"CurrencyDecimalSeparator":".","IsReadOnly":false,"CurrencyGroupSizes":[3],"NumberGroupSizes":[3],"PercentGroupSizes":[3],"CurrencyGroupSeparator":",","CurrencySymbol":"$","NaNSymbol":"NaN","CurrencyNegativePattern":0,"NumberNegativePattern":1,"PercentPositivePattern":0,"PercentNegativePattern":0,"NegativeInfinitySymbol":"-Infinity","NegativeSign":"-","NumberDecimalDigits":2,"NumberDecimalSeparator":".","NumberGroupSeparator":",","CurrencyPositivePattern":0,"PositiveInfinitySymbol":"Infinity","PositiveSign":"+","PercentDecimalDigits":2,"PercentDecimalSeparator":".","PercentGroupSeparator":",","PercentSymbol":"%","PerMilleSymbol":"\u2030","NativeDigits":["0","1","2","3","4","5","6","7","8","9"],"DigitSubstitution":1},"dateTimeFormat":{"AMDesignator":"AM","Calendar":{"MinSupportedDateTime":"@-62135568000000@","MaxSupportedDateTime":"@253402300799999@","AlgorithmType":1,"CalendarType":1,"Eras":[1],"TwoDigitYearMax":2029,"IsReadOnly":false},"DateSeparator":"/","FirstDayOfWeek":0,"CalendarWeekRule":0,"FullDateTimePattern":"dddd, MMMM dd, yyyy h:mm:ss tt","LongDatePattern":"dddd, MMMM dd, yyyy","LongTimePattern":"h:mm:ss tt","MonthDayPattern":"MMMM dd","PMDesignator":"PM","RFC1123Pattern":"ddd, dd MMM yyyy HH\':\'mm\':\'ss \'GMT\'","ShortDatePattern":"M/d/yyyy","ShortTimePattern":"h:mm tt","SortableDateTimePattern":"yyyy\'-\'MM\'-\'dd\'T\'HH\':\'mm\':\'ss","TimeSeparator":":","UniversalSortableDateTimePattern":"yyyy\'-\'MM\'-\'dd HH\':\'mm\':\'ss\'Z\'","YearMonthPattern":"MMMM, yyyy","AbbreviatedDayNames":["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],"ShortestDayNames":["Su","Mo","Tu","We","Th","Fr","Sa"],"DayNames":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],"AbbreviatedMonthNames":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec",""],"MonthNames":["January","February","March","April","May","June","July","August","September","October","November","December",""],"IsReadOnly":false,"NativeCalendarName":"Gregorian Calendar","AbbreviatedMonthGenitiveNames":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec",""],"MonthGenitiveNames":["January","February","March","April","May","June","July","August","September","October","November","December",""]}}';
Sys.CultureInfo.CurrentCulture = Sys.CultureInfo._parse(__cultureInfo);
delete __cultureInfo;
Sys.UI.Behavior = function(b) { Sys.UI.Behavior.initializeBase(this);
    this._element = b; var a = b._behaviors; if (!a) b._behaviors = [this];
    else a[a.length] = this };
Sys.UI.Behavior.prototype = { _name: null, get_element: function() { return this._element }, get_id: function() { var a = Sys.UI.Behavior.callBaseMethod(this, "get_id"); if (a) return a; if (!this._element || !this._element.id) return ""; return this._element.id + "$" + this.get_name() }, get_name: function() { if (this._name) return this._name; var a = Object.getTypeName(this),
            b = a.lastIndexOf("."); if (b != -1) a = a.substr(b + 1); if (!this.get_isInitialized()) this._name = a; return a }, set_name: function(a) { this._name = a }, initialize: function() { Sys.UI.Behavior.callBaseMethod(this, "initialize"); var a = this.get_name(); if (a) this._element[a] = this }, dispose: function() { Sys.UI.Behavior.callBaseMethod(this, "dispose"); if (this._element) { var a = this.get_name(); if (a) this._element[a] = null;
            Array.remove(this._element._behaviors, this);
            delete this._element } } };
Sys.UI.Behavior.registerClass("Sys.UI.Behavior", Sys.Component);
Sys.UI.Behavior.getBehaviorByName = function(b, c) { var a = b[c]; return a && Sys.UI.Behavior.isInstanceOfType(a) ? a : null };
Sys.UI.Behavior.getBehaviors = function(a) { if (!a._behaviors) return []; return Array.clone(a._behaviors) };
Sys.UI.Behavior.getBehaviorsByType = function(d, e) { var a = d._behaviors,
        c = []; if (a)
        for (var b = 0, f = a.length; b < f; b++)
            if (e.isInstanceOfType(a[b])) c[c.length] = a[b]; return c };
Sys.UI.VisibilityMode = function() { throw Error.notImplemented() };
Sys.UI.VisibilityMode.prototype = { hide: 0, collapse: 1 };
Sys.UI.VisibilityMode.registerEnum("Sys.UI.VisibilityMode");
Sys.UI.Control = function(a) { Sys.UI.Control.initializeBase(this);
    this._element = a;
    a.control = this };
Sys.UI.Control.prototype = { _parent: null, _visibilityMode: Sys.UI.VisibilityMode.hide, get_element: function() { return this._element }, get_id: function() { if (!this._element) return ""; return this._element.id }, set_id: function() { throw Error.invalidOperation(Sys.Res.cantSetId) }, get_parent: function() { if (this._parent) return this._parent; if (!this._element) return null; var a = this._element.parentNode; while (a) { if (a.control) return a.control;
            a = a.parentNode } return null }, set_parent: function(a) { this._parent = a }, get_visibilityMode: function() { return Sys.UI.DomElement.getVisibilityMode(this._element) }, set_visibilityMode: function(a) { Sys.UI.DomElement.setVisibilityMode(this._element, a) }, get_visible: function() { return Sys.UI.DomElement.getVisible(this._element) }, set_visible: function(a) { Sys.UI.DomElement.setVisible(this._element, a) }, addCssClass: function(a) { Sys.UI.DomElement.addCssClass(this._element, a) }, dispose: function() { Sys.UI.Control.callBaseMethod(this, "dispose"); if (this._element) { this._element.control = undefined;
            delete this._element } if (this._parent) delete this._parent }, onBubbleEvent: function() { return false }, raiseBubbleEvent: function(b, c) { var a = this.get_parent(); while (a) { if (a.onBubbleEvent(b, c)) return;
            a = a.get_parent() } }, removeCssClass: function(a) { Sys.UI.DomElement.removeCssClass(this._element, a) }, toggleCssClass: function(a) { Sys.UI.DomElement.toggleCssClass(this._element, a) } };
Sys.UI.Control.registerClass("Sys.UI.Control", Sys.Component);
























    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(generate);

    function showCalendar() {
        var imgCntr = document.getElementById("imgPeriod1");
        var posTop = imgCntr.offsetTop;
        var posLeft = imgCntr.offsetLeft;
       
        var divPopup = document.getElementById("popupControl");
        divPopup.style.display = 'inline-block';
        divPopup.style.top = posTop + 19 + divPopup.offsetHeight / 2;
        divPopup.style.left = posLeft;

        // устанавливаем период в контрол при открытии
        var dates = ($('div.divCalendar1 input').val() + "," + $('div.divCalendar2 input').val()).split(',');
        $('#inlineDatepicker').datepick('setDate', dates);
        
    }

    function showCalendar2() {
        var imgCntr = document.getElementById("imgPeriod2");
        var posTop = imgCntr.offsetTop;
        var posLeft = imgCntr.offsetLeft;

        var divPopup = document.getElementById("popupControl");
        divPopup.style.display = 'inline-block';
        divPopup.style.top = posTop + 20 + divPopup.offsetHeight / 2;
        divPopup.style.left = posLeft;

        // устанавливаем период в контрол при открытии
        var dates = ($('#ctl00_cphMain_ctl06_inlineDay').val() + "," + $('#ctl00_cphMain_ctl06_inlineDay2').val()).split(',');
        $('#inlineDatepicker').datepick('setDate', dates);
        
    }

   

    function hideCalendar() {
        var divPopup = document.getElementById("popupControl");
        divPopup.style.display = 'none';
    }

    function generate () {
        $('#inlineDatepicker').datepick({
            rangeSelect: true,
            monthsToShow: 1,
            minDate: '01.01.2014',
            maxDate: +0,
            renderer: $.datepick.weekOfYearRenderer,
            firstDay: 1,
            onShow: $.datepick.selectWeek,
            //calculateWeek: customWeek,
            onSelect: getRanges
        });

        function customWeek(date) {
            return Math.floor(($.datepick.dayOfYear(date) - 1) / 7) + 1;
        }

        function getRanges(dates) {
            $('div.divCalendar1 input').val($.datepick.formatDate(dates[0]));
            $('div.divCalendar2 input').val($.datepick.formatDate(dates[1]));
        }

    }