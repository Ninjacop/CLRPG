(load "/Users/Ninjacop123/Desktop/OceanGame/functions.lisp")
(load "/Users/Ninjacop123/Desktop/OceanGame/fishing.lisp")
(load "/Users/Ninjacop123/Desktop/OceanGame/farming.lisp")

(defparameter  *allowed-commands*  '(debugg tend harvest plant showcrops makehouse makekit makepick makeaxe makerod makespear use-medkit findflax sew cast reel monopoly begin tutorial hunt chop mine forage showinv eatberry eatcrab makeaxe cook toolinfo stats))
(defun game-eval (x)
  (if (member (car x)  *allowed-commands* )
    (eval x)
    '(Invalid Command)))
(defun start ()
  (loop (print (eval (read)))))
(defun start ()
  (let ((cmd (game-read)))
    (unless (equal (car cmd) 'quit)
      (game-print (game-eval cmd))
      (start))))
(defun game-read ()
  (let ((cmd (read-from-string (concatenate 'string "(" (read-line) ")"))))
    (flet ((quote-it (x) (list 'quote x)))
      (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))
(defun tweak-text (lst caps lit)
  (when lst
    (let ((item (car lst))
          (rest (cdr lst)))
      (cond ((equal item #\space) (cons item (tweak-text rest caps lit)))
            ((member item '(#\! #\? #\.)) (cons item (tweak-text rest t lit)))
            ((equal item #\") (tweak-text rest caps (not lit)))
            ((or caps lit) (cons (char-upcase item) (tweak-text rest nil lit)))
            (t (cons (char-downcase item) (tweak-text rest nil nil)))))))
(defun game-print (lst)
  (format t (coerce (tweak-text (coerce (string-trim "() "
                                                  (prin1-to-string lst))
                                     'list)
                             t
                             nil)
                 'string))
  (terpri)
  (stats))

;-----------------------------------------;
(defparameter *hurt* nil)

(defparameter *blood* 0)
(defparameter *bloodchance* 0)
(defparameter *hunting* 0) 
(defparameter *inventory* 0) 
(defparameter *woodcutting* 0) 
(defparameter *mining* 0) 
(defparameter *health* 0) 
(defparameter *fishing* 0) 
(defparameter *sewing* 0)

(defparameter *field* (make-hash-table))
(defparameter *tools* (make-hash-table))
(defparameter *toolkit* (make-hash-table))
(defparameter *meat* (make-hash-table)) 
(defparameter *cookedmeat* (make-hash-table))
(defparameter *fish* (make-hash-table)) 
(defparameter *cookedfish* (make-hash-table)) 
(defparameter *wood* (make-hash-table))
(defparameter *minerals* (make-hash-table)) 
(defparameter *berries* (make-hash-table)) 
(defparameter *axe* (make-hash-table)) 
(defparameter *fishingrod* (make-hash-table)) 
(defparameter *cloth* (make-hash-table)) 
(defparameter *flax* (make-hash-table)) 
(defparameter *medkit* (make-hash-table))

(setf (gethash 0 *meat*) 0) 
(setf (gethash 0 *cookedmeat*) 0) 
(setf (gethash 0 *fish*) 0) 
(setf (gethash 0 *cookedfish*) 0) 
(setf (gethash 0 *wood*) 0) 
(setf (gethash 0 *minerals*) 0) 
(setf (gethash 0 *berries*) 0) 
(setf (gethash 0 *axe*) 0) 
(setf (gethash 0 *fishingrod*) 0) 
(setf (gethash 0 *cloth*) 0) 
(setf (gethash 0 *flax*) 0)
(setf (gethash 0 *medkit*) 0)

(format t "~%~%~%~%~%~%~%~%~%~%~%~%~%~%~%~%~%~%;----------------------------------------------------------------------;~%~%~%~%Type (start), then \"tutorial\" to start the tutorial! Type \"quit\" to quit ~%If you know how to play, type \"begin\" ~%Your goal is to make a house!~%~%~%;----------------------------------------------------------------------;~%~%~%~%~%~%~%")
