package com.tylercako.track531.controller.view

import com.tylercako.track531.model.dto.SubmittedWorkout
import com.tylercako.track531.model.view.ExerciseCard
import com.tylercako.track531.model.view.SplitCard
import com.tylercako.track531.model.view.WorkoutPage
import lombok.extern.slf4j.Slf4j
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.ModelAttribute
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.SessionAttributes

@Controller
@SessionAttributes("workout")
@RequestMapping("/workout")
@Slf4j
class WorkoutController {

    @GetMapping()
    fun currentWorkout(): String {
        return "workout/currentWorkout";
    }

    @PostMapping()
    fun submitWorkout(submittedWorkout: SubmittedWorkout, @ModelAttribute workout: WorkoutPage): String {


        return "redirect:/workout/currentWorkout"
    }

    @ModelAttribute("workout")
    fun getWorkoutPage(): WorkoutPage {
        return WorkoutPage(
            workoutId = "1",
            workoutName = "Squat Day",
            exerciseCards = listOf(
                ExerciseCard(
                    name = "Back Squat",
                    splitCards = listOf(
                        SplitCard(id = 1, weight = 100f, reps = 1),
                        SplitCard(id = 2, weight = 90f, reps = 3),
                        SplitCard(id = 3, weight = 80f, reps = 5),
                    ),
                ),
                ExerciseCard(
                    name = "Bench Press",
                    splitCards = listOf(
                        SplitCard(id = 4, weight = 70f, reps = 1),
                        SplitCard(id = 5, weight = 65f, reps = 3),
                        SplitCard(id = 6, weight = 60f, reps = 5),
                    ),
                ),
            ),
        )
    }
}