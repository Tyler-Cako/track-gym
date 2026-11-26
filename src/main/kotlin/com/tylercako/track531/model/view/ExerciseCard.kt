package com.tylercako.track531.model.view

import com.tylercako.track531.model.db.Exercise
import com.tylercako.track531.model.db.Split

data class ExerciseCard(
    val name: String,
    val splitCards: List<SplitCard>,
)

data class SplitCard(
    val id: Int,
    val weight: Float,
    val reps: Int,
)

fun Exercise.toCard(): ExerciseCard {
    val oneRepMax = this.oneRepMax;
    val splitList: List<SplitCard> = listOf(split1.toCard(oneRepMax), split2.toCard(oneRepMax), split3.toCard(oneRepMax));
    return ExerciseCard(this.name, splitList)
}

fun Split.toCard(oneRepMax: Float): SplitCard {
    val weight = this.multiplier * oneRepMax;
    return SplitCard(this.id, weight, this.reps)
}