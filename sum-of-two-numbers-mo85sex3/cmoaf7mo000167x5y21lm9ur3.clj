(require '[clojure.string :as str])

(let [[a b] (map #(Long/parseLong %) (str/split (str/trim (slurp *in*)) #"\s+"))]
  (println (+ a b)))