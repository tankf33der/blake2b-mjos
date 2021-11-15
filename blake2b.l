(de mono_blake2b (L K O)
   (default O 64)
   (let (Len (length L)  Ken (length K))
      (use R
         (native
            "libmonocypher.so"
            "crypto_blake2b_general"
            NIL
            (cons 'R (cons (cons O 'B O)))
            O
            (cons NIL (cons Ken) K)
            Ken
            (cons NIL (cons Len) L)
            Len )
         R ) ) )
(de mjos (L K O)
   (let (Len (length L)  Ken (length K)  R)
      (native
         "libmjos.so.0"
         "blake2b"
         NIL
         (cons 'R (cons (cons O 'B O)))
         O
         (cons NIL (cons Ken) K)
         Ken
         (cons NIL (cons Len) L)
         Len )
      R ) )
(test
   (mono_blake2b (mapcar char (chop "abc")) (1 2 3) 8)
   (mjos (mapcar char (chop "abc")) (1 2 3) 8) )
(for O 64
   (for K (range 0 64)
      (for D (range 0 256)
         (let (Key (need K 255)  Data (need D 255))
            (test
               (mono_blake2b Data Key O)
               (mjos Data Key O) ) ) ) ) )
(msg 'ok)
(bye)
