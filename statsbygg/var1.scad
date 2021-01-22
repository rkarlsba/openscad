function _PrintFixedRec(x, prec, d, s) =
  let(
    dig = x < 0 ? 0 :
      (prec == 1 ?
        floor(x % 10 + 0.5) :
        floor(x % 10)
      ),
    s2 = str(s, dig),
    s3 = d == 0 && prec>1 ?
      str(s2, ".") :
      s2
  )
  prec<=1 && d <=0 ?
    s3 :
    _PrintFixedRec((x-dig)*10, prec-1, d-1, s3);

function _ZeroStr(i) = i <= 1 ? "" : str("0", _ZeroStr(i-1));
function _Decimate(x, i=0) =
  x == 0 ? [0, 0] :
  (x < 1 ?
    _Decimate(x*10, i-1) :
    (x < 10 ?
      [x, i] :
      _Decimate(x/10, i+1)
    )
  );
  
function _PrintFixedPos(x, prec) =
  let(
    dec = _Decimate(x),
    xsc = dec[0],
    d = dec[1],
    s = d >= 0 ? "" :
      str("0.", _ZeroStr(-d))
  )
  _PrintFixedRec(xsc, prec, dec[1], s);


function PrintFixed(x, prec=15) = x < 0 ?
  str("-", _PrintFixedPos(-x, prec)) :
  _PrintFixedPos(x, prec);


c=1000002;
d=0.000002;
pi=-3.14159265358979323846264338327950288419716;
echo(c); //1e+06
echo(d); //2e-06
echo(PrintFixed(c));
echo(PrintFixed(c, 6));
echo(PrintFixed(d));
echo(PrintFixed(d, 3));
echo(pi);
echo(PrintFixed(pi));
echo(PrintFixed(pi, 20));
echo(PrintFixed(1e20));
echo(PrintFixed(12345678901234567890, 7));
echo(PrintFixed(12345678901234567890, 30));
