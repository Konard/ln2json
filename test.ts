import { describe, expect, test } from '@jest/globals';
import { ln2json } from './index'

describe('ln2json tests', () => {
  it('((1 2)(3 4))', async () => {
    const source = '((1 2)(3 4))';
    const target = '[[[1,2],[3,4]]]';
    expect(JSON.stringify(ln2json(source))).toBe(target);
  });
  it('((5 6)(7 8))', async () => {
    const source = '((5 6)(7 8))';
    const target = '[[[5,6],[7,8]]]';
    expect(JSON.stringify(ln2json(source))).toBe(target);
  });
  it(`(5 6)
(7 8)`, async () => {
    const source = `(5 6)
(7 8)`;
    const target = '[[5,6],[7,8]]';
    expect(JSON.stringify(ln2json(source))).toBe(target);
  });
  it('(mama: (ma: m a)(ma: m a))', async () => {
    const source = '(mama: (ma: m a)(ma: m a))';
    const target = '[{"mama":[{"ma":["m","a"]},{"ma":["m","a"]}]}]';
    expect(JSON.stringify(ln2json(source))).toBe(target);
  });
  it('(parent: (child: a b)(child: c d))', async () => {
    const source = '(parent: (child: a b)(child: c d))';
    const target = '[{"parent":[{"child":["a","b"]},{"child":["c","d"]}]}]';
    expect(JSON.stringify(ln2json(source))).toBe(target);
  });
});