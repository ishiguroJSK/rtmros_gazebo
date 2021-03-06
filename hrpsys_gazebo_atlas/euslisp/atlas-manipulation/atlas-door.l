(load "package://hrpsys_gazebo_atlas/euslisp/atlas-interface.l")
(load "package://hrpsys_gazebo_atlas/euslisp/atlas-fullbody-ik.l")


(load "package://euslisp/jskeus/eus/models/room73b2-door-right-object.l")
(load "package://atlas_prog/models/atlas-hook-model.l")


(defun init-door-setting
  (&optional (robot-x -800)
	     (robot-y 0)
	     (robot-yaw 0)
	     (view t))

  (setq *door* (room73b2-door-right))
  (send *door* :door :max-angle 100)
  (send *door* :door :min-angle -100)
  (send (elt (send *door* :links) 2) :assoc
	(send (send (send (send *door* :handle-front-knob) :translate #f(200 0 0))
		    :rotate (deg2rad -90) :x) :rotate (deg2rad 180) :z))
  (send (elt (send *door* :links) 2) :assoc (send *door* :handle-rear-knob))
  (if view (objects (list *door*)))

  ;; (atlas-init-ex :real nil)
  (unless (and (boundp '*atlas*) *atlas*)
    (atlas-with-hook)
    (send (send *atlas* :larm :end-coords) :translate #f(100 0 0))
    (send (send *atlas* :rarm :end-coords) :translate #f(100 0 0)))
  (if view (send *irtviewer* :change-background #f(1.0 0.9 1.0)))

  (setq *robot* *atlas*)
  (init-fullbody-ik-main)

  (init-door-pose)
  (send *atlas* :fix-leg-to-coords (make-coords :pos (float-vector robot-x robot-y 0) :rpy (list (deg2rad robot-yaw) 0 0)))
  (make-foot-convex)

  (if view (objects (list *atlas* *door* *foot-convex* *centroid-object*)))
  )

(defun init-door-pose
  ()
  ;; (send *atlas* :reset-pose)
  (send *atlas* :reset-manip-pose)
  ;; (send *atlas* :larm :inverse-kinematics (make-coords :pos (send *atlas* :larm :end-coords :worldpos) :rpy (list 0 0 0)))
  ;; (send *atlas* :rarm :inverse-kinematics (make-coords :pos (send *atlas* :rarm :end-coords :worldpos) :rpy (list 0 0 0)))
  )


(defun open-first-door-side
  (&key (wait t))

  (init-door-setting -650 -100 80)
  (send *atlas* :reset-manip-pose)
  (make-foot-convex :force? t)
  (objects (list *atlas* *door* *foot-convex* *centroid-object*))
  (send *atlas* :angle-vector #f(0.0 3.0 0.0 120.0 100.0 5.0 -65.0 35.0 90.0 -126.851 167.544 66.7547 37.286 27.6476 111.557 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))


  (send *atlas* :angle-vector #f(0.0 3.0 0.0 120.0 100.0 5.0 -65.0 35.0 90.0 -135.0 162.593 67.5002 24.9209 27.1113 104.142 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :angle-vector #f(0.0 3.0 0.0 120.0 100.0 5.0 -65.0 35.0 90.0 -135.0 157.148 67.5002 20.5246 26.5905 97.5366 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))


  (send *atlas* :angle-vector #f(0.0 3.0 0.0 120.0 100.0 5.0 -65.0 35.0 90.0 -130.656 111.167 20.8357 36.3135 45.0 83.7744 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))


  (send *atlas* :rarm :move-end-pos #f(-25 0 0) :world :revert-if-fail nil)
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))


  (send *atlas* :rarm :move-end-pos #f(0 0 -100) :world :revert-if-fail nil)
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :rarm :move-end-pos #f(0 0 -100) :world :revert-if-fail nil)
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :rarm :move-end-pos #f(200 0 0) :world :revert-if-fail nil)
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :rarm :move-end-pos #f(100 -30 0) :world :revert-if-fail nil)
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :rarm :elbow-y :joint-angle 40)
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))
  )

(defun open-first-door-front
  (&key (wait t))

  (init-door-setting)
  
  (send *atlas* :fix-leg-to-coords (make-coords :pos (float-vector -600 -200 0)))
  (make-foot-convex)
  (objects (list *atlas* *door* *foot-convex* *centroid-object*))

  (send *door* :door :joint-angle 0)

  (send *atlas* :fix-leg-to-coords (make-coords :pos (float-vector -600 -200 0)))
  (send *atlas* :angle-vector #f(0.0 3.0 0.0 30.0 90.0 0.0 -80.0 15.0 0.0 -30.0 90.0 0.0 80.0 15.0 0.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :fix-leg-to-coords (make-coords :pos (float-vector -600 -200 0)))
  (send *atlas* :angle-vector #f(0.0 3.0 0.0 38.2318 103.99 67.4934 -69.5466 44.9938 9.69183 -30.0 90.0 0.0 80.0 15.0 0.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :fix-leg-to-coords (make-coords :pos (float-vector -600 -200 0)))
  (send *atlas* :angle-vector #f(0.0 3.0 0.0 66.0538 104.993 67.4967 -56.2476 44.9965 6.95405 -30.0 90.0 0.0 80.0 15.0 0.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :fix-leg-to-coords (make-coords :pos (float-vector -600 -200 0)))
  (send *atlas* :angle-vector #f(0.0 3.0 0.0 124.399 74.4945 54.4666 -90.0002 45.0 58.0857 -30.0 90.0 0.0 80.0 15.0 0.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :fix-leg-to-coords (make-coords :pos (float-vector -600 -200 0)))
  (send *atlas* :angle-vector #f(0.0 3.0 0.0 122.506 74.0491 44.3159 -87.2984 32.7219 62.924 -30.0 90.0 0.0 80.0 15.0 0.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :fix-leg-to-coords (make-coords :pos (float-vector -600 -200 0)))
  (send *atlas* :angle-vector #f(0.0 3.0 0.0 90.2822 57.3814 53.0032 -86.961 13.8468 77.5915 -30.0 90.0 0.0 80.0 15.0 0.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :fix-leg-to-coords (make-coords :pos (float-vector -600 -200 0)))
  (send *atlas* :angle-vector #f(0.0 3.0 0.0 65.2799 23.3657 47.3225 -77.0115 -31.6247 91.902 -30.0 90.0 0.0 80.0 15.0 0.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *door* :door :joint-angle 20)
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :fix-leg-to-coords (make-coords :pos (float-vector -600 -200 0)))
  (send *atlas* :angle-vector #f(0.0 3.0 0.0 77.8246 84.6192 11.7062 -43.9257 -10.2838 38.2024 -30.0 90.0 0.0 80.0 15.0 0.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :fix-leg-to-coords (make-coords :pos (float-vector -600 -200 0)))
  (send *atlas* :angle-vector #f(0.0 3.0 0.0 95.3494 89.2775 11.3158 -44.5046 7.47507 37.8462 -30.0 90.0 0.0 80.0 15.0 0.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))

  (send *atlas* :fix-leg-to-coords (make-coords :pos (float-vector -600 -200 0)))
  (send *atlas* :angle-vector #f(0.0 3.0 0.0 124.399 74.4945 54.4666 -90.0002 45.0 58.0857 -30.0 90.0 0.0 80.0 15.0 0.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))
  (send *irtviewer* :draw-objects)
  (if wait (read-line) (unix:usleep (* 200 1000)))
  )

(defun open-second-door-front
  (&key (wait t))

  (init-door-setting 750 400 -180)

  (send *atlas* :angle-vector #f(0.0 3.0 0.0 133.387 125.213 4.24709 -66.1523 32.52 90.2245 -120.0 100.0 -5.0 65.0 35.0 90.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))

  (send *atlas* :angle-vector #f(0.0 3.0 0.0 118.437 115.185 -1.65525 -81.5932 15.9529 91.772 -120.0 100.0 -5.0 65.0 35.0 90.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))

  (send *atlas* :angle-vector #f(0.0 3.0 0.0 107.79 99.3277 -9.86138 -81.0096 -8.76787 94.8195 -120.0 100.0 -5.0 65.0 35.0 90.0 28.0 -1.7 -12.5 1.7 -15.5 0.0 28.0 1.7 -12.5 -1.7 -15.5 0.0 0.0))

  (send *atlas* :larm :move-end-pos #f(15 0 0) :world :revert-if-fail nil)

  (send *atlas* :larm :move-end-pos #f(0 0 -100) :world :rotation-axis nil :revert-if-fail nil)

  (send *atlas* :larm :move-end-pos #f(0 0 -150) :world :rotation-axis nil :revert-if-fail nil)

  (send *atlas* :larm :move-end-pos #f(100 0 0) :world :rotation-axis nil :revert-if-fail nil)

  (send *atlas* :larm :move-end-pos #f(100 -20 0) :world :rotation-axis nil :revert-if-fail nil)

  (send *atlas* :larm :move-end-pos #f(100 -20 0) :world :rotation-axis nil :revert-if-fail nil)

  (send *door* :door :joint-angle 30)

  (send *atlas* :rarm :angle-vector #f(-117.745 83.6972 -67.5002 64.5406 21.0539 74.7479))

  (send *atlas* :rarm :angle-vector #f(-106.029 113.208 -23.7951 33.3744 -28.2753 52.5088))

  (send *atlas* :rarm :angle-vector #f(-99.7026 114.146 -34.9985 42.5944 -42.1653 55.4058))

  (send *atlas* :larm :move-end-pos #f(0 0 100) :world :rotation-axis nil :revert-if-fail nil)

  (send *atlas* :larm :move-end-pos #f(100 -100 0) :world :rotation-axis t :revert-if-fail nil)

  (send *atlas* :larm :angle-vector #f(28.5 114.5 0.0 -75.0 17.0 0.0))

  (send *atlas* :rarm :move-end-pos #f(50 -100 0) :world :rotation-axis nil :revert-if-fail nil)

  (send *atlas* :torso :waist-y :joint-angle 15)

  (send *door* :door :joint-angle 50)

  (send *atlas* :torso :waist-y :joint-angle 30)

  (send *door* :door :joint-angle 70)

  (send *atlas* :rarm :angle-vector #f(-120.0 100.0 -5.0 65.0 35.0 90.0))

  (send *atlas* :stand-pose)
  )






















;; old demo

(defun try-door
  (&optional (door-rotate-angle -30.0))

  (init-door-pose)

  (grasp :real nil)
  (let* ((div-num 20.0)
	 (arm :rarm)
	 (hname :handle-front-knob))

    (send *door* :door :joint-angle 0)
    (dotimes (i div-num)

      (if
	  (null (apply
		 #'fullbody-ik-main
		 (list
		  :target-limb (list arm :lleg :rleg)
		  :target-coords (list (send *door* hname) nil nil)
		  :additional-weight-list
		  (mapcar
		   #'(lambda (k gain)
		       (list (send *atlas* :torso k :child-link)
			     gain))
		   (list :waist-r :waist-p :waist-y)
		   '(0 0 1))
		  ;;(list 1e-3 1e-3 1e-3))
		  :root-link-virtual-joint-weight
		  (float-vector 0 0 0 0 0 0)
		  :min-vec (min
			    (scale
			     -1
			     (map float-vector
				  #'*
				  (float-vector 0 0 0 0 0 0)
				  #F(1000 1000 1000 200 200 200))))
		  :max-vec (map float-vector
				#'*
				(float-vector 0 0 0 0 0 0)
				#F(1000 1000 1000 200 200 200))
		  :collision? t
		  :debug-view :no-message
		  ;; :centroid-thre 200
		  ;;:target-centroid-pos nil
		  :thre '(100 1 1)
		  ;;:stop 100
		  :rotation-axis '(nil t t))))
	  (format t "fail~%"))

      (send (send *door* :door)
	    :joint-angle (- (/ door-rotate-angle div-num)) :relative t)
      (x::window-main-one)

      (unix:usleep (* 200 1000))
      ;; (read-line)
      )))

(defun try-push-door
  ()
  (init-door-setting -550 -100 80)
  (try-door -90))

(defun try-pull-door
  ()
  (init-door-setting -700)
  (try-door 30))

(defun try-door-demo
  ()
  (do-until-key
   (try-pull-door)
   (try-push-door))
  )

(defmethod atlas-robot
  (:door-pre-pose () (send self :angle-vector (float-vector 0.0 3.0 0.0 117.193 75.6237 28.4498 -64.3526 39.0765 78.3247 -85.6098 101.869 10.52 77.8411 -74.4278 83.6718 28.0 -1.7 -12.5 1.7 -15.5 -6.516951e-16 28.0 1.7 -12.5 -1.7 -15.5 -2.815605e-16 65.6002))))

