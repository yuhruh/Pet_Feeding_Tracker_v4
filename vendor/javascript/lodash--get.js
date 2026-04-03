// lodash/get@4.17.23 downloaded from https://ga.jspm.io/npm:lodash@4.17.23/get.js

import{_ as r}from"./_/CMfEiC89.js";import"./_/C6UayejR.js";import"./isArray.js";import"./isSymbol.js";import"./_/BvE8bFHC.js";import"./_/Dn0SV0nH.js";import"./isObjectLike.js";import"./_stringToPath.js";import"./memoize.js";import"./_/zyyNK3QO.js";import"./_/slH5hUxU.js";import"./_/CX3pl0wT.js";import"./isFunction.js";import"./isObject.js";import"./eq.js";import"./_/LlMKPN53.js";import"./toString.js";import"./_/vyAkOenX.js";import"./_arrayMap.js";import"./_toKey.js";var i={};var t=r;
/**
 * Gets the value at `path` of `object`. If the resolved value is
 * `undefined`, the `defaultValue` is returned in its place.
 *
 * @static
 * @memberOf _
 * @since 3.7.0
 * @category Object
 * @param {Object} object The object to query.
 * @param {Array|string} path The path of the property to get.
 * @param {*} [defaultValue] The value returned for `undefined` resolved values.
 * @returns {*} Returns the resolved value.
 * @example
 *
 * var object = { 'a': [{ 'b': { 'c': 3 } }] };
 *
 * _.get(object, 'a[0].b.c');
 * // => 3
 *
 * _.get(object, ['a', '0', 'b', 'c']);
 * // => 3
 *
 * _.get(object, 'a.b.c', 'default');
 * // => 'default'
 */function o(r,i,o){var s=r==null?void 0:t(r,i);return s===void 0?o:s}i=o;var s=i;export{s as default};

