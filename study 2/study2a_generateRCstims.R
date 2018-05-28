# install.packages("rcicr")
require(rcicr)

# BF-BM:
generateStimuli2IFC(list("base" = "BF_BM_50%_frame_grayscale.jpg"),
                    n_trials = 300, 
                    img_size = 400,
                    stimulus_path = "./stimuli_bfbm_400x400_t300",
                    label = "bfbm")

# BF-WF:
generateStimuli2IFC(list("base" = "BF_WF_50%_frame_grayscale.jpg"),
                    n_trials = 300, 
                    img_size = 400,
                    stimulus_path = "./stimuli_bfwf_400x400_t300",
                    label = "bfwf")

# WM-BM:
generateStimuli2IFC(list("base" = "WM_BM_50%_frame_grayscale.jpg"),
                    n_trials = 300, 
                    img_size = 400,
                    stimulus_path = "./stimuli_wmbm_400x400_t300",
                    label = "wmbm")

# WM-WF:
generateStimuli2IFC(list("base" = "WM_WF_50%_frame_grayscale.jpg"),
                    n_trials = 300, 
                    img_size = 400,
                    stimulus_path = "./stimuli_wmwf_400x400_t300",
                    label = "wmwf")